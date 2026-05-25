Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E357CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2168F848CF;
	Mon, 25 May 2026 17:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R9P1Xsbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F982848C6; Mon, 25 May 2026 17:15:44 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46356848CE
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bcd0111ea98so1359697066b.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722142; cv=none;
 d=google.com; s=arc-20240605;
 b=Y3K4qei9oyoBdWsvWbJKPjOwglN1fJz1TBeVWLXhuF9TmbFEn6wcYrraFXBf5kTMZu
 fbhtuLk3otyV1TbdBDBGQaJEDFSM88p9X0bT45hNcGdP7vvmbU/wClf2rwXl+MRWZpwb
 yAACUaj4CKcvQF720g8CDJ0W/jeK9O8yl52sR5eaQO9o/u/5TQ6RbHgoBnxXxC+mWjTE
 5L/7SvvcoFlRt0YyIWihWKKWaHVfLJxl2HGWV27w8JEYz11HrLTyFfpOxtcWf9/phm5e
 RrKPZIr5pMBHjh4bGfYui2VMQ85/b17F9lpOI3qfIlIT477wvDwEpOsomUNBTMyD9XP/
 Pwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RQFV4v1qhWKm13FkRLzBRtpZiFjrlQN1Q/zDqUN3qJU=;
 fh=ap4HBTS9iAjB+V3u/70LwXRdUUxzrXw6cYQOpndKL8Q=;
 b=LBWroOSLm/wCsm14Q5x6Y6lmmK5udYmes5rf15fb/foKTatuku3QRruhZNPpcIMkwk
 DQXGfXSfjlmPQKmmp2dke64zY11GaUFpFmIimmFRKPqKRiCKjRDk+kZwlEBQqidLiGPv
 BASaIeWygO1fuRQWqRs9TquH442AnYsjBKC849T5HqG6z4+QvOzR642umNyLm1YBv05b
 /DFA5omftV9PnKub4T/DbcneWxVsmR9bdyLJmsg9PIVYtPLMl8KDpKHRgFVq24efo/JA
 V7TyM61oz0DKXmlHvYHT9qiNsbNY6AQOv5GZpPvT+aF/jqaYxicItgRWVlFoccCbTxA2
 49KQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722142; x=1780326942; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RQFV4v1qhWKm13FkRLzBRtpZiFjrlQN1Q/zDqUN3qJU=;
 b=R9P1Xsbv3PwHzsNm9paabK+5g8RmCzh2AzQ/Yji7vL9ctJJKbYk8PXB0bgqtJ8VrMz
 yami0ldoR/nyfd+PR4FoR/GV3Y73omNI5tCZ5dQF/RRB7arqP41Oo5IgU4AhVDn5DZJZ
 tR25M80fE3TD2kMl3cYYVq9aRXm36CAPcI06g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722142; x=1780326942;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQFV4v1qhWKm13FkRLzBRtpZiFjrlQN1Q/zDqUN3qJU=;
 b=UVXCpFOvFjZq1x56jd1UN1ohoTEjxNrnuHEQGsK70b4ZvIY5xFS/SCAimZ3X0BaL+I
 8jA2SPotDFSCYA1+4XCWwzrHUOQEYx23ASu05/oukjSLy8AjOtt0rhyOKEtySD++S0dN
 aXQ6c5bZvjT/dBmsykZoxllOAXV4fw4H+U5s/nInxs1gy1tvf6ITovLdra8ZzevLBzEi
 P4B4cs9n4TR+I3KDH/ihCEFB6q2xxD4+XVe0Xu6nrARgur2kj2P4PHAZc25bWQpxlxw0
 ypOMoRh3gDMvPuFlJ8IpAr0tgy3da4MsC3jeTGJEy5W9+NYgWtqR34laQrx1KnDnCkR1
 VsbQ==
X-Gm-Message-State: AOJu0YwYdVgIPDyNApVwLKkQjlhtnTUN6ER/dttjNn8KuhLgCLBMNrW9
 Uxz47lZs1b5rrgXCfGeO/c19Ir5HwuqWmCGyeq97PdvexlHLcC2ymnpLTuW5RBZPorH2p7i7iXv
 A2i4GHn4G1ZZ4s/n2wRu1GpGSjA8P2e0MrqiDYmWM
X-Gm-Gg: Acq92OH94gJG7JP4RG4Qq1zMup7Z9//lPO6bvJmjfFkZUH4IqEtLsuUFzxVK06Y+sFA
 NRAz/UvXatBZun87j69zHlkARKguszXGSF20IHGDaJitQjFmBAlK/zVt1OoP/RustspfjL0pBEJ
 IRrZEN8Qo4jexWQ5pfbRl7HTa0nBpBt/SjSbFFuveEvAB2Vt/VthmWOB/gmoWOYEiv/Qp1X/ciD
 dzKA9B61iD0dsjHabWztPLGCm7V7cHD1nF0nf/7PXiNKhRTaN1XG/fxFoNAvSuvTFq9z0Gue1vX
 4usIrw==
X-Received: by 2002:a17:907:d0b:b0:ba1:1181:b773 with SMTP id
 a640c23a62f3a-bdd2839b9cdmr826493366b.10.1779722141676; Mon, 25 May 2026
 08:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260521165122.17475-1-josh2@disroot.org>
 <20260521165122.17475-2-josh2@disroot.org>
In-Reply-To: <20260521165122.17475-2-josh2@disroot.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:15:23 -0600
X-Gm-Features: AVHnY4JE02ZltmMsO_5sWPWq3NsonszueFBl832i9hHnBQbGyW6MVQECaObc1mE
Message-ID: <CAFLszTi=B1qdrh+4bzPA1RQ-RqCcvVwSJy5A9FwrtzH+Q5f6nA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libavb: fix avb_replace() OOM handling
To: josh2@disroot.org
Cc: u-boot@lists.denx.de, mkorpershoek@kernel.org, igor.opaniuk@gmail.com, 
 trini@konsulko.com
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

On 2026-05-21T16:51:21, Josh Law <josh2@disroot.org> wrote:
> libavb: fix avb_replace() OOM handling
>
> avb_replace() promises NULL on OOM. Once it had built the first
> replacement, a later allocation failure returned that partial buffer.
> Callers treat any result as success, so AVB could keep booting with
> truncated bootargs.
>
> Free the partial result and return NULL. The existing callers can then
> take their OOM path.
>
> Signed-off-by: Josh Law <josh2@disroot.org>
>
> lib/libavb/avb_util.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
