Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9477DCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EC43846E1;
	Fri, 15 May 2026 16:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iMRepMkY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDDD4846E7; Fri, 15 May 2026 16:01:57 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B7E80086
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bd394f4a931so672274466b.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778853715; cv=none;
 d=google.com; s=arc-20240605;
 b=lQXwopFDoDI7WxyeSL1BFqlh/wrGId6CrSDcIn9KM9e9+w68MJvrXZIL6RVd2sOKWw
 9dMv7o0jZYaNKEPjzSiM1vp38qaDpMK65qjlONY8A981maHhJ1CI/lnnmnlVFRoTRgR7
 LEdy5NmMeho16TiHGhvGi0s7R0dTL/Sm3QrJIs0S1ItdDnQXS8gtQtQ9Kedfl0PzqLMe
 5sAvZ2pm4kFgv5QYrVv2NMTmGDmNs2dDm69MQo4dvrRKyJRSaRKeOvpQXH9hU4b+WmN6
 CFiDYtKhUmKOlWYpEI6HkUjvIrYtFwkEizWSrAGvDis+Uegy1RAGMTLXF2L8/slveMKn
 hw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LIjaVUKsnOVvOYflOYAJP7LC4/4089aRbvE7+av+06g=;
 fh=iKDWrTcgwoa9C1ACNePkkwpn0tsK8/zzKurdVLHRlhQ=;
 b=E1+SlCP/rxmE8SCeUBGAjWkUJHrZFWae2FfCUCU+C85XG+hDTcW/TITkpOfgJnCueQ
 l+ksfIC+IQeJGG7pYereLiIUqsDTXffJo/nSGpNbl+0fYAo/wuJNNP+kdVrwAl1qVDhk
 8FUcTWZ5RUk41Y6ks/lsadf1idp85ae8qG9DOwgyR4Q5Fk959ccvxts1GHWMzy5FruVb
 AWGobM7pI7fJv95zfqhBnWWw8tBXzB/a4qDKJw/OQ1L8NJ8yPXn+NWKmMI6Hx2k9iZaN
 Ofj+TP0KbyV9WdFIvHVoo4hHwkDLZpwOZ+lM0yi7Ix1YQmu4MlPaMLXO5WkAIpi7kp9Y
 desA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778853715; x=1779458515; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LIjaVUKsnOVvOYflOYAJP7LC4/4089aRbvE7+av+06g=;
 b=iMRepMkYLXYHaG56Cky4xWFjRsHDYggLzzkRoUXKAFQZoH9H2vbMBUe7VrC4txi8P/
 b/7kDJnzmfGACLUIACo5lE1Mz+uZado4ofd7oeOGtbZOBfZk4OsRtaf7dGH5azF+3t9c
 EcfabH5+XrK8hq0Yi4II0P0H5usqeBGsnbJfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853715; x=1779458515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIjaVUKsnOVvOYflOYAJP7LC4/4089aRbvE7+av+06g=;
 b=josKbR90CnV2Jjp1MWs33u8E2dZuuss2rLwT42KwBcIGKBCbaI1Pw0jrTfrSL8y/3f
 03J81uZxJtlHBGi2Onfx39NNRgxw5ewHbsTdkLr4VpPr+t/J/iHym/VWDUOqkj9jgL7S
 bKZ1jlBvjNxL693yYYz06DlhJArO58iwOW3kOdnFWoX6w8I+loEmlcNdpdQmRiAzjF14
 ErG78zxIIZ71Nt1KsjuXcuLUUEemxeaN5sIXjoBCRPJPyM/zTMhiFJte2naBvX4B0xUJ
 CftqS3L/x5aqIeK38CMLedLuBn5ItyqDz2Q/mQHMql0/C7QjWk4MaYfoHdYsbN7qHO02
 ak7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+c/ShV5TVn+pTJ2RDNb8ssCopkPbgGF8ek8y+bLe8RjnJIoFkQshaYDDiNseLw605xu+GZXk=@lists.denx.de
X-Gm-Message-State: AOJu0YzGZLdqQTKv3t5doCs016o++Wx8BOXxGDU/P/lVjYBjCrMD3OmA
 DopWJDTVNl4KXdF+32VJoWO+hZnMXzo6Y4mu0kavoFr8BToD4T+cyplsjgDXVyvZvutospC/6y2
 oWvBpHsdyQlGyAdjDEPrg1KJc3+JxUy48BSKIBb0UTag53qDaQNk=
X-Gm-Gg: Acq92OEKXUVFlCTLdDrIDde2MWfIK1wV9bWM4cLTxJj3QwH4VkAuA5hLjU+kTjP/US/
 XXA2J77KoS0TBle0XHicIXF0MvQ9KaF4juoanFN4GWA+AyFQy7/dKd681w3IEm00RxmTfT9faPr
 Ve0ePZ1jXzLo0jLNKG5JRDedYevS5S1Kl7f4t5FZo4Ro7eWrTfOC3YzbgjuztWhK836GXF6Wjfy
 5NcaUhvYc5B6IPSWWzqMJLsdF7V6prdbGAGphfvVqUHD2unsqlGJt8IW0TYK13EKRzXVtnLzsLT
 SaNzKA==
X-Received: by 2002:a17:906:b3a5:b0:bd5:18e8:1ae4 with SMTP id
 a640c23a62f3a-bd518e8236fmr141838066b.34.1778853714613; Fri, 15 May 2026
 07:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260515054327.1033466-1-w.egorov@phytec.de>
In-Reply-To: <20260515054327.1033466-1-w.egorov@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 08:01:42 -0600
X-Gm-Features: AVHnY4J-cM85dlU9zi0g0fwzHuyFXw7ezJ6mENqDzwUjyeSboNtPJxNAuy8cKj8
Message-ID: <CAFLszTiKV=SmsBt7k7ZnmczygD9oJ_kyNkM0ScZb3go-a_K8WQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
To: w.egorov@phytec.de
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, u-boot@lists.denx.de
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

On 2026-05-15T05:43:27, Wadim Egorov <w.egorov@phytec.de> wrote:
> Makefile: binman: Search board directory before srctree
>
> A file like rm-cfg.yaml accidentally left in the source tree root
> shadows the board-specific copy. binman builds the wrong YAML, the
> resulting rm-cfg.bin may match a different SoC, and we end up with
> the following error:
>
>   k3_system_controller sysctrler: k3_sysctrler_start:
>       Boot Notification response failed. ret = -110
>
> Move the board directory ahead of the srctree root so that the
> most-specific match wins.
>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>
> Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
