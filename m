Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC47ECDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2AA84996;
	Thu, 25 Jun 2026 14:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bEweLSRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A74284894; Thu, 25 Jun 2026 11:25:25 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC04D84704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 11:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjm2473@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-8ce0f17a69cso16153446d6.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 02:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782379521; cv=none;
 d=google.com; s=arc-20260327;
 b=k90dZ/OOt3VIXPdk9N5CSFfPCMrGNtxbwnn/coGLyKKHYjgC3ImoVXzN7RI2OzHnBf
 mZT6bHn3vE/InNOCZ+Ia2+oc4FXci9YJzcZXGO0CYLmgGGdCeod05tQgs66pkEFa1cU1
 WZI9WLeY59aVrf6+WeSPTSiWFUf8iajBdDWN/zcuycq+6tJZE3qGcN0kF7zXNlt11OW0
 DyjQnLUktsnU9UbMmtOyMLkP7G6/UA/gwmM5l0i1ZMpX8bd84eWn7os5LCIIO/M8Axpg
 jCbUxoQHmrZtXPT6Vkcmf+ClJCjt9q86bEatxaGqiufLaxmPH5FHH7JVngAN4gGdNGmA
 W/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=026/qN0ps0DLDR91lFZJx3PLPNmWZyCF0D3+YSlcKUc=;
 fh=x73HISMD02Ddlm4UL9P4qFt+bKnpXc6gYNbl/Hv7Q+Q=;
 b=E+hprruoWyCPfbTITBGCFkGWN62J1LM467DjFumTzZjMRNkRWhF+j5uD6tGtbfgu2m
 z7pwdbeyiKVDZtk+r8WbwETqerHeRH6uhj6QjIwVHbkxlYbX8K3EV6tds5fGANTfKe4w
 A5x9DmjhgYcGcIti6VAWrWP9yg/ZRLaIwL9QpidHMq0GITBwdB28PEpVOnZneweNngpi
 GI8KL+lwyQt/VDjshPEaXgOolub3bJHWrH71QOmA5t9EOQg6xq3B5htXUzGf5jHfdVm2
 FOPxvDRjWPs0yJaSi+czTcmsLlB/+MzsO+kzyETHuRjMQsXRmB9qc3hch+Ob9gMdu87T
 ajhg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782379521; x=1782984321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=026/qN0ps0DLDR91lFZJx3PLPNmWZyCF0D3+YSlcKUc=;
 b=bEweLSRdXE9xMDut9RuYtMpTcMafihS+Gza5sarhB3pzWsswTVUH+Qe8hl7rdvt/7t
 7KykoG3hJbI3BeUaBnD2ZoxZ7UEwZXYW75hlP7t7m5pRo6qtJI4PMW9uFPZ6SoZBY9JS
 4SNDXRPRnzdd26mehOPKTxwTBMTsPWakcStesYxf9CNEcPWb3NGJIEJYOXvafG5o+UC5
 NcsScGZd6LxBIuE7p0eVSgTEsWGKiI68KfQtAa9veeISLDXEOlGaI/l4V3L8BUc++cWJ
 5QRopjXFANkkSNHE6Ir5Xzrl6y8jbKic1eKpXBZfH1pZyQWBrIuCMN/rbijiAQq1+D8a
 TqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782379521; x=1782984321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=026/qN0ps0DLDR91lFZJx3PLPNmWZyCF0D3+YSlcKUc=;
 b=Kp+k3WN7QXNz4VypHp+Sz8NLEIuTZs3FjhUXnIchVmFMZAEAFM1MAL9yivUft32scm
 fFxs7EV31M5WcrqhjdgUDBO0lTHh4M5hc28XTQdn18xn+bDm4b96fophz/cct1btvOGl
 W2AZfO2nUwme6uAAFHYEwL5XyOZ3isRjLwfmDdeQR6ficZ/DOYDFURcmCa355nWvEtP0
 N6b0IajPUbt+30YHAPuE6J95DuV2Qd/JKgJxxCIy5TRBbq0v/tH2NyKXzX4RZUM5hnL+
 eiFFU5bMb3KEFGsaswfjMv7Mxh65/lXvl1NnJRmK31153Np7V/5EkVlMm+NaPJqFlwSO
 6ljA==
X-Gm-Message-State: AOJu0YxNj0unvHvvLqqoyIXaDRikOV02n3+Q/qO2r1bdPT4kEfyJZP6u
 OyzwriyGMqYh6C1iyGCiLt+gED8fnAhTebSOd0JimH93EOEUHOuLOTBLBEUOlnRMo4qmZaLg+DO
 0sU6vKlHpUCy1UccaxIZlgFi+Pomlf+542xVhBUd5c3pa
X-Gm-Gg: AfdE7clPCFe/0iADWShzYBVxvoUacFQuEyD0lGmh3hXitzhra8gbeVaOH0iaqSul1pX
 VH/2wXNqoRKu3xhSEwH2Ew2G+rv+qoq9ppSBV8Rskhyaou3vdx8hwtjll0LeAT2EQym5+F40Ohb
 RZWaUKdiOJVX8Ec0RGmX1q6b4+JSdLd5s4O9SVRfID/6HYXEp351NW+5NAPlLTs83dNAqiE42o5
 SmQ29CKT5xd7pKf+tlQvrbY6dSVAmMpxh0TBADpLrm0sUbday1v6f7fPdM/jG5GTiX1Z+Q=
X-Received: by 2002:a05:6214:4506:b0:8b2:13cd:ad38 with SMTP id
 6a1803df08f44-8e6d6781076mr30802506d6.11.1782379521370; Thu, 25 Jun 2026
 02:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260512091532.97256-1-jjm2473@gmail.com>
 <20260512091532.97256-2-jjm2473@gmail.com>
 <b2b25f9e-336e-419f-b2a0-e5942df246af@cherry.de>
 <CAP_9mL409bOVu1kg-y07ZxNpfdb--g8A1T2hUbRUetXfeMF81w@mail.gmail.com>
 <be4cde3b-4565-48b8-9e12-40a874c89bc1@cherry.de>
In-Reply-To: <be4cde3b-4565-48b8-9e12-40a874c89bc1@cherry.de>
From: Liangbin Lian <jjm2473@gmail.com>
Date: Thu, 25 Jun 2026 17:25:09 +0800
X-Gm-Features: AVVi8CeNlUSG6mt6aazQav2VP6lOux6PrC1zk1q7Z9b26IYgaclGjyo0Op76cUk
Message-ID: <CAP_9mL7kfqbwEeokHdt7j53uioAEp4QCsxvYFxBsPogdn22phQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] rockchip: rk3568: Add support for LinkEase EasePi R1
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

Hi Quentin,

> So I guess it's "fine" (although you won't be able to do a proper secure
> boot with this enabled). So you can keep it in.

I discovered that OpenWRT is still using the legacy U-Boot image file
format script [1], too.
And the `source` command for executing this type script also requires
 `CONFIG_LEGACY_IMAGE_FORMAT=y` [2].

Therefore, CONFIG_LEGACY_IMAGE_FORMAT=y is still required in many
open-source projects.
(Actually, Armbian also used the legacy U-Boot image file format script)

[1] https://github.com/openwrt/openwrt/blob/7edb29d241dbd4acd0a716a3735dedd5ac3b36e2/target/linux/rockchip/image/Makefile#L24
[2] https://github.com/u-boot/u-boot/blob/master/doc/usage/cmd/source.rst

Cheers,
Liangbin
