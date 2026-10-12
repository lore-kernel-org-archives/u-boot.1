Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CACFCA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 07:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DACC680AED;
	Mon, 12 Oct 2026 07:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q1FqarTiVae0; Mon, 12 Oct 2026 07:47:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2BA7D80A82
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791263;
	b=BsZpIr0MSlV8Pe0TXApW1P5plK+uYtIKDqzUK0Fxq/3n57+LEjhHqgwjBJ8JjA6ErlYw
	 pDn6rBbcFLbGPuLcLPko1vZR5jFLmWgNkq/TYiYsnn6KqPgJfe4C8dDv0cizRWf5hT04B
	 FoQN/ANXCb5FtA5WoENnZTEZJgBCKTEbi1+xe22MgxbAcX8gAvaLl8vmJdO1lqhQTHf2M
	 eXLetn4YAL/kpT8Wd96McyWTP6UjDI1DM0txkVKQq7wF9uFo2omMntaMUgLHEgpd9E20n
	 Ihn4qEaG8CCRjnhOmetq2gCTi77nTkyhOiwGSqwghhMTeG+gWOm5Y4cUBXzW8JK3WKw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791791263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2IpQkm7Pvz4/4j3zheJ9jO8FakhzZdfntEUFJsmUBQc=;
	b=bGfduw/LOkex70R/wTETm+ttpQB7KRxa9ia1V9K+mGGFJazh8jy6HXOa+Q8AeFgk2ktH
	 DF/AwHM6D2D9x2SATyAkz0/g8esqDRHzWpvfDEBAKChGAboPC79Ik7gT5mnHtvWy3PFvw
	 Bltba5gxIyVGcS8DutqVydHcRMNk0ns/LO8p4PRQYVOgM/8IXaCwz+rqmZkZFDn8oKtXG
	 0fBARi+KyH4PnP9V+Jv+u79Mhi3bKQyRsNsYXvQ0vPil6Cq+Govqq2O0BlqZuT8xj1Stv
	 N7KZF+1VyBc1YUoJQT53cJPgY8F5dgn/VCekkUJbWBrFrD8GMQLxA8Jb3wNHCOUn6wg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791791263;
	bh=2IpQkm7Pvz4/4j3zheJ9jO8FakhzZdfntEUFJsmUBQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l+dKmaBIhPVX3CShWB2UiM6F0uiJEUFwmABUyIUw/Oc9o3huElHCpKsrcZ8WzejKM
	 C0RkPT6f92L4rfaOFd6zAVemjSdHEBPa1YQofsvaPd5Wc/TourcUT14ezS8ZOBdcEQ
	 73O4sBRxgjAR0K3ksE5Fi1d6+TRum7Ii5YYugj0PU9uh8R+GL6Da60CgRVsHSJi9zx
	 n+csuUqkypldxIIi3GLf3wfaSFO7QhnKextMxMvXVfx2u10ovwkPeKDS8A3eIrXnUI
	 YNQTPwJOUhR+ct8QOvGDrnjnVWgHIhiq8OFC3S0bG3F9Ire9BX0N5wzVURfacPsp6p
	 kcTq7w8sVmbiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BA7D80A82;
	Mon, 12 Oct 2026 07:47:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC2D32E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D19224002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:47:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEUv4PjEBr21 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 07:47:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DFD4940024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791261;
 b=E7BMRimPXX6On6bJ9tUIdsWnosRn4e53A7yQRUJxA1MoIqFx3eceFV5WwEfmeMWP1Q7p
 KIU5BfcZLCNnVazPDLe/7WXcXAOI3ibd2+ft8pxYR7rAdYjuNlo6+V0eO/GhPU3i+UOT3
 Je5ou1zyA8/K2pT1Ia6gbpNri4UG2qP+3zmQ5cf62zvaqa8YEm3AJikG9HxRLj9NGz+2C
 Wm3IB88Iu6SsoeTSM+JMQDA+Ekc2BluJB3O8KPygP4+VbHD4k+wZwzlt/dGaiV6rhrUNX
 GdfjLynh/DHxpSRYeQdtoR2WOuqVC8Sxuvgmpblg+3t4gei7fH87hw3xCMfdfvDTeSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791791261;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=2IpQkm7Pvz4/4j3zheJ9jO8FakhzZdfntEUFJsmUBQc=;
 b=URjVgmwtR/+hFm75lh7UtXSxxjAQHUhIrWaIOT9JHNhDLVk9UmvZgU3Hq9Du4bx2rcDk
 HjGgqK5MyP9KphtPBte6zdMZthfSjmrM9xIzumZIBPWTJVewWC36zrmNx8RwK92qvix9F
 TrZeSbGabWSY784idvxI4J5LPY0Cgc2VAkYHcZYgqLGDty6AN0ebbPb5sftIG8dS9jKj1
 O+GByKFQTyDGgszMB3b3/rzRov9DsKmh545qUTJYN0XFzRVlfFg1FE78fStqqkXC2EmEO
 3gbEyQOrCSSlSW7FMxBqK3sBf+3IxVGsTe5s9bBlWajbA4LLC8AFXLndr6P+U0NRtkQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Uf0NKbbh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Uf0NKbbh
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFD4940024
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:47:40 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so1297320a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 00:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791791258; cv=none;
 d=google.com; s=arc-20260327;
 b=C7nwUi8d8l9hnTaJxTkLhKbbnSlaCo9jQxB1isu5vFS+Wo3vgzU6MbjXxS84yCPG6D
 FNYjD7pN6tcg4gDXOsql0LzfiCoMguKg6RHWFGbXR2yQAqmk66EPfcSHeFe6migUrhho
 gsRCKMjtSZutFtOGhj6WS2m4sXTeDrMDFJD0TV+EV6wXYJgsZEOknokJVwRRMsLiqFQ+
 a7l81Bq0Kc/4OAFedt/P5XntEhC/I8bu9LT6WqeJkUsVbumyR49h/uLccrDd/N8if8U4
 hSMfpzgww/9PZMXcqSKlINVZ98ipQzxMC8pnmED22GQvvId1euNZfU805gDdUqcXbhRg
 lYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2IpQkm7Pvz4/4j3zheJ9jO8FakhzZdfntEUFJsmUBQc=;
 fh=wbP4qAhiI8Lk/DEUjFBl49BCohTz8UK30uaiUZ9HbtQ=;
 b=iV3Txk3lXCvVDl+wS5FS5DE9rKO00N6WYEcEtkhGpHnRcbNHrRUh998BL1z9rGjTp5
 Dh2uTjN1BI/77qq2Z0zNiq6t83dL4Uj4AofEV5j4P5Or82epCWCDx/TMNCrXxsCCuohC
 n81Mt1dDjc+Vm3IAU2Os8EEOyPgRc5yATqm18ycHoXK+TDMByK6AdDiSp4RFpxNb4oLd
 O6LkLo5t2IzRFcLgs0MoYWoAa+4G3tMzRWmd0gTCyeT2BGD7jpTZxtHgHY3EgsEKljdw
 n2UHQML5F78tScJu95ACCuL0NLrHZ66DwpFPgSYipufMJdmBV9q1lAuP0t8D46ET508x
 81hg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791791258; x=1792396058;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2IpQkm7Pvz4/4j3zheJ9jO8FakhzZdfntEUFJsmUBQc=;
 b=Uf0NKbbhA5y4dy/z52HMch47IF2f/7DJ8P7zB7yuw7cFBD319uMeAzEpl/QdGyXjWB
 1FMU1SkDCxQXX2WRPQyjO4U6VcKTV94ErJZv4Dr/Z+vmjqy8hTQYvnZno4QZm4EI5mLc
 GyeVaFjfAeVQkqyfl5LqWtbmXA8bkpbI6gg5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791791258; x=1792396058;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2IpQkm7Pvz4/4j3zheJ9jO8FakhzZdfntEUFJsmUBQc=;
 b=Ul7pgViU7gdlYAKQowuoxGj9EMSEaYt6pI6eJvUc7Tj/h9PFhPovKD93ov7W73RDkk
 E/OGr1bOCUxfzQNgGZMsdfAstdox9LOrIf3q0UoVA22rLz+gz0xRelftICdBIpvonGs9
 Hp+cEFdV4hGvDVkS5Xohsd2GFjMFIiM5ny8lRl0Y5xYaAp1+FINCJmF69aJCvvI2V430
 Q2R+zbT4PxblLPAwrQJn6FhsPaYO6Bq4rF9aCigVZDMHKibWCqklBKTatcRNbjZLlPDu
 fuM8iX9rgUpGwBm0hDBM7/Vum2dNZOCDNyRxXQd4ftZ6KqQbakVROldH1X4sQaWY9qSh
 ySwA==
X-Gm-Message-State: AFq9FYIqwg6NFOm0cx1c17fyv1ZE02p0Svi8uhF2RV8KMjT5EdA1FTa7
 Xdm5/rjPI7gp0xHIF2ATdx/AfsZGgJ7A4/Y7tGiFI0o33SlVUaTAPZQsaTqnlzk79qHS6aLQ140
 GVKraqZzlGlx3VHwHYpaiEAtGMctS2OJZeyKZxQzF
X-Gm-Gg: AYBFou34fYitjG1lWp1ndqdXBzfJdFdmy9HLdxsZEtXV/jTGfDY2dJyGNjRuyl4uAG/
 iMORVxDb4kFo0pWr5SsVHsLMmXkUpeqAGC+7IKmjaKGsHTNQppEKtQK17cz8Avm915XQE8nhhLR
 IO4Cbp6Sote1uipV6my5q4KA+BGefXJkRzEWoAaQa8qU3ChI5OGF2UWtbyNuY8i1NnY/TqbG98y
 9hM0ZIdoKSyolTUW5WmwSR1J7jzQiB0knneVmLyE01M4yFdnCHAYyuxdI0vQnVmtjZ9GEqVHUrX
 N4pi6RMf3irLCzFcleZWyepW/gWcgR+z4gIDFubPsECodMW4ZeklF0ervA==
X-Received: by 2002:a05:6402:3241:b0:6b1:c355:c7aa with SMTP id
 4fb4d7f45d1cf-6b1c355ce43mr1022920a12.0.1791791258183; Mon, 12 Oct 2026
 00:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20261006155217.187050-1-michael.haener@siemens.com>
 <20261008215518.209510-1-michael.haener@siemens.com>
 <20261008215518.209510-4-michael.haener@siemens.com>
In-Reply-To: <20261008215518.209510-4-michael.haener@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 08:47:25 +0100
X-Gm-Features: AclHuK8p0dDzs2WtHXRM1UJ8ENq5fSbGhrJgJOWDq24A1X0A8FzouUusFS-GFEM
Message-ID: <CAFLszTh2ttM83W9Xr-0EJHce5J4mz5x7cpF7aqrSEG2r-9eTjQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] xilinx: Use CONFIG_TPM_AUTOSTART on Kria
To: michael.haener@siemens.com
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Michael,

On 2026-10-08T21:55:17, Michael Haener <michael.haener@siemens.com> wrote:
> xilinx: Use CONFIG_TPM_AUTOSTART on Kria
>
> The Kria boards start the TPM with a 'tpm autostart' call in the board
> environment. Enable CONFIG_TPM_AUTOSTART instead and drop tpm_setup from
> the environment, so the TPM is started even when the preboot script is
> changed or skipped.
>
> The TPM is now started before preboot, so the TPM reset hints for some
> carrier card revisions are printed after the startup. Boards which still
> have the old environment saved run 'tpm autostart' a second time, which
> is harmless.

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> board/xilinx/zynqmp/zynqmp_kria.env  | 4 +---
>  configs/xilinx_zynqmp_kria_defconfig | 1 +
>  2 files changed, 2 insertions(+), 3 deletions(-)

Regards,
Simon
