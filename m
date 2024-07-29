Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28978C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B2788892;
	Mon, 29 Jul 2024 17:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D/camFH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CCB8888F; Mon, 29 Jul 2024 17:28:53 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1894888886
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-44fe9aa3bfaso20734541cf.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266930; x=1722871730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m/VG59/eExnqD3bzAftMVkKuc6BkKrbBspm29P/x+00=;
 b=D/camFH9iczBgp0qwUDkc8mnJr/rrmi/CT2ex5+n9q+9yuOLuzSwyho27sT7HVPGX9
 YiOBkCQ67a0e0iUQE08F2cOSfawnyp5GxSxq7u5J35jHWjDYAsVxFgYGGCLx2Iaxh+pa
 eiwX7/lZwnHtarGUXoXE6F4o75Rcb7slTG9cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266930; x=1722871730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/VG59/eExnqD3bzAftMVkKuc6BkKrbBspm29P/x+00=;
 b=Ik5IcRVLRO57joev5X2dOgZyuiHLgStq17aPIHyLWtNw7qOjhudujB4nPiD8MPm097
 CD6xPTYKAAiDs7vmTeO3psbEeal/B/zvqP+9ro1qoQ11yFX++Xxcg7G019+mrgPSK2Qy
 2k4E/zZJTGB+p2ypvfqSRoUMHW1P5czXifquxvAV2WBmTqHHFnvdRJ2xmsCn/1YqcxEz
 KM23xbK2P7g0CB6EcAWxGLfgnHXXnwsqFxJSkbkNs/PtRYalBf4+xKLIaqzrH4D9AXmg
 G6psgOmONlHw9dB859Bmyz4B0Dsg0VFh/+wF3znK5fvcWfgsm2xCWb4wbCGfqViyLKRp
 eItQ==
X-Gm-Message-State: AOJu0YySWvliA2yvC2EO2ioNCciUL1Lww6Y5aZg6VAjkQw7UesXCaVnf
 TtvVQ8prAb/b6fjB5orVwLq6Z5MtHMIZhE7ZfInI/QBM0PoVsYXgS04xptU8oUf8mVoQmlfkZS/
 /Hc/51bgQxhNRHaH8dOxFtueGJOw5+2YeStS4
X-Google-Smtp-Source: AGHT+IFeXUPmOaiAuhT+iIP1pqIA7VolWM99EfFvjpeQazUOcM42pZ+G2SGUzKCtb0WR8ebGqMl7cmJZeh67n6uFAEQ=
X-Received: by 2002:ad4:5c6a:0:b0:6b5:d663:bb53 with SMTP id
 6a1803df08f44-6bb559b7e12mr130030266d6.5.1722266930065; Mon, 29 Jul 2024
 08:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-10-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-10-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:39 -0600
Message-ID: <CAFLszTj_XgL3KQma2QPzDp8M--VWH+ss5UvLr3XSLovSkAi-PQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] acpi: Add ACPITAB for PPTT and GTDT
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Return the ACPI table revision in acpi_get_table_revision() for
> PPTT and GTDT. Match both to ACPI 6.2.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  include/acpi/acpi_table.h | 2 ++
>  lib/acpi/acpi_table.c     | 4 ++++
>  2 files changed, 6 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
