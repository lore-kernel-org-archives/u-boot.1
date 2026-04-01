Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5184910FCAC9
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 19:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D62D084011;
	Wed,  1 Apr 2026 21:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M9an0Hwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B32C384020; Wed,  1 Apr 2026 21:19:46 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4AE280517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 21:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9910707d82so11200666b.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 12:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775071184; cv=none;
 d=google.com; s=arc-20240605;
 b=bhymOMCEobZbsubA4sCE2FIZJZWkBNYQQRz9f6RFJ8kF+XuzLBZPFgjUB8pVvUfPm/
 bpWI06Re3j61R6RlGTx1T5LsMC3S5QG7C1H8mMHlw1WVEs5OjXUK71fiPQx13Ri42P+p
 JKXUvDE1Lz/6DIONb7oScw+52QdTb8mnJYxYzmQaTTRN5aEX++ZsABra95pahTTk7SZV
 WnGa3NERDTElwnM25V/344K1sJwTcrUJgE9psyjpGdr59yzGDkaLL9biKLf9JdJ3wBJ3
 vYkXeCpvSP9/gj+prm2YzycxcUnqVlj8o4HuvZ4xJtDu3Xqt+xJI5HrNNhlYdlZgMZjr
 msGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dnVfM7mxFS0P/4yyfBt1Mp68/QSIItYODdAUaDT9Lb4=;
 fh=NUQiOC7vn/JScfhA2cOZ09ja1hwcxDS4qfwnkq4H4fw=;
 b=eVUYWRvcRHtAY+M20PSJJtLT1ebBisdJ7Wdz+lkAg7bjMF9SheSYm8pBquFVk1VMig
 uH7ETjVYpU0MjKtsbz97uYfjUdjQp02HaKbeiUUnaKWtC2C7PgWQ5Bq/sXbf7YWxyP5k
 butssuZVCT5RChZyde2PeyBxzngAsFOhVrfaUEMl9LRIobhwGav6paHikx/bDqyHrxhn
 V33W5rOajoBvDRGLoTYdAWvxRxZY2uU+swRAtebNFNurIY76HWk/u217ObJpmI1QFQaI
 mc7KJ7MESMfrv7HqXBjRYvkxiK8JSE/Rvpgkx8EyqKA8j79/mRVJCU3nUYpk2KnCsx5K
 0vWA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775071184; x=1775675984; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dnVfM7mxFS0P/4yyfBt1Mp68/QSIItYODdAUaDT9Lb4=;
 b=M9an0HwvCTVhpmySkrkm7hsmkmX/AycSvs/AjFiKYui0br3kqSLg3iK+hfJrJKWD5B
 HAGMVSxyOwPrf8vFG6mF/hfV0TKBA4sn0HNNi8Tbdb/WJ81mS7OxTuOXkQVSwQmTmaq+
 t4xApPyDFkEWqZRMGNjD3fGgyNS6IgHL0N270=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071184; x=1775675984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnVfM7mxFS0P/4yyfBt1Mp68/QSIItYODdAUaDT9Lb4=;
 b=FTTIwwfD/HgSLl29dmZCWaS7YAsfXc2YWI1GoXYppdEIgSo1mQb4wF7DgqZJBEE+VP
 OD0oqYn2oqlPWletBuJ5TJIXMe1N/PdlE6f5GmbQSpZFk0hBo0FWyzAwHM7efRa5p6qI
 ugRZjDLub7zduhMRmMVgJjGbJH+5zcJGtEIH7aw+aXPrgolQheEUVEwmSmnAdz8ra3+z
 46Z9Z2xGhfdW1EI91UVkzYGmPvQXHnbb0Mbk2nXeqc/6GXfi1iFMrZB6idf79Ia7oJx1
 EATQzM2OEARmpJFbsbo6hwYP9RbygE818F/UbORPo/gPcxiQC60UTtvWFnhkjb/R74S2
 a6Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSHf7wtOHGlC7EVZllmiDMhoJSpX1kqHpo/PDw+FqQa8Cwrq8Th6R/GStsFqX+9HRfM04vhd0=@lists.denx.de
X-Gm-Message-State: AOJu0YyYLNqm2OJlavas3Q3MErx75XLGvjkUqXiawpGZOXjNJNmZzl52
 kHhC3ejdSoGJ0GF3A2vGDowEEkVTLuQdVBc32zvaeTxwRs7HHcQucfnAjD7YDrDmC0IVTI64g9H
 hPUyYzNCqa1dJeQz4X+dctDiXKRQrii9Q+nbJGAhI
X-Gm-Gg: ATEYQzyF+L9XDdMzdz7DjFBZDariTw54xFUmvymWvSjWULnZtzuoaO8Km7T/hgOEYEQ
 jSwj4UsB8ofP5M0IA4y5u4y8bZ5J4eDnp13H+kQMV7jFifm/Shvz9VkxsFZLpVeksUrHEaqZqSW
 TQkr16OWVwCliJy57tL0fnEMBTscs1W5ayktoqZQnfBBFN8rzKXlTzFtT61Cg5gZuap71dodF7R
 +znd63PdaKxwSC1Y5MhN/qQ7j4qvDzjN4tdPZCSuYhKK9YnG84bARX7eAjwSZXmBCYBsLls57uu
 BAkRFiRX5ZofSgNtE1xC0lVV/9Wc+ds77xc5QzN9
X-Received: by 2002:a17:907:d096:b0:b9a:cb5e:5354 with SMTP id
 a640c23a62f3a-b9c138e2a77mr341777566b.16.1775071183745; Wed, 01 Apr 2026
 12:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-3-ilias.apalodimas@linaro.org>
In-Reply-To: <20260331080117.2370092-3-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 15:19:27 -0400
X-Gm-Features: AQROBzAKCLQZOLjvWBm85gA21XxliBFKGrEj3TcYM4eNaxV7mwVQ7Ma0CIxCv7c
Message-ID: <CAFLszThkFW33WhbQzEETqET_qQPxz7hfeYhR7L=VsWryDOrmZQ@mail.gmail.com>
Subject: Re: [v2,2/4] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
To: ilias.apalodimas@linaro.org
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

On 2026-03-31T08:01:10, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> fdtdec: Introduce fdtdec_setup_mem_ram_top() to determine end of topmost DRAM bank
>
> Introduce function fdtdec_setup_mem_ram_top(), which determines the topmost
> address in the last DRAM bank, to be assigned into gd->ram_top in order to
> relocate U-Boot to the actual end of all DRAM. This makes use of iterator
> function fdtdec_setup_mem_for_each_bank() introduced in previous commit.
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
>
> include/fdtdec.h | 16 ++++++++++++++++
>  lib/fdtdec.c     | 18 ++++++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
