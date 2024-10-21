Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6C4D3DEA1
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 06:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE5B6891A7;
	Mon, 21 Oct 2024 08:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gRvWeiyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C03892BA; Mon, 21 Oct 2024 08:32:03 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0EC7890D1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbf2fc28feso28601986d6.0
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 23:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729492317; x=1730097117; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VfysVss3NIYEU2n4gwURsnTg99a8sUSZlK5KWJN1Lvk=;
 b=gRvWeiylFEkLxAP4LN4GcSXy7kzf+IRkNaaDZEmyGhEkMtK+R3xOufCo/DjoLENw2I
 P1EhAJkEE6pgsaeLF+FGZLTliAfGEUnMRNwlynmO2kq7ErWKB/1h2EK8JcsEtmuHxV6n
 Hwy50YzLenQkVB5JJsEOx2p8uXya57zs3jIEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729492317; x=1730097117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VfysVss3NIYEU2n4gwURsnTg99a8sUSZlK5KWJN1Lvk=;
 b=pktF3xojStH9ItY3tDz/M+VUUpdxP/yRdgsPfTvC/tKU7XLf8GqvUiyT8q9BatY64b
 iYe60KNGTKSZ4WE74Y8M5zKrPrreE/ke4dQuUEgEvh87Nbe/qLdVycQSJW4vgbu9AkRH
 rFh4pcuoZUMg/koAfn5mPBSC4mOeSHc4hxIjafikMHGfUHDqX7NMgdv0leBou4w6NAMJ
 37lFcRk/imxw7kW0uht9RBuEUjGjJykqX7VNd6PEgPC2zroQANbHa4/wcVWGY+4C5HFQ
 cLNAxw2HSr51jx/czF37BPEDQIQKzqfN4byQ3Fb18wqEoMbAjFJp0YugZOfm0ut4XSGl
 jkeQ==
X-Gm-Message-State: AOJu0YwsXRr2RsWd/0d74hYSg/bE5wpIifjXgiZsNNv2zbOzgcfXCQRN
 Ab9QrymAwr0WYm8wib8GS8m3cStPFDDtb2mQWm8AjNQFzC5z3a0pU3n7M4O0kd83VYdzguNbH9E
 kjJGenlA75aP9+wKIcK44FkuzJm8y0XTG9eMClU7v7wSV0tAjamrtjFs=
X-Google-Smtp-Source: AGHT+IHh8TMHACnzx6qSSmOKFHIE/Qauc0IW6a+VX+QOowUGwOPBxa8Fd+TmNCsD2UTjfwgQPisSY5SsNpPMmoJ8RV4=
X-Received: by 2002:a05:6214:3f86:b0:6cc:b4:5dcb with SMTP id
 6a1803df08f44-6cde1639b87mr230060096d6.47.1729492316761; Sun, 20 Oct 2024
 23:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241020154323.43308-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241020154323.43308-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 08:31:45 +0200
Message-ID: <CAFLszTiNBNm6ve5i9DmFdZ8pFm1KspCgEUxDNnoiGV_MJz2NCg@mail.gmail.com>
Subject: Re: [PATCH] boot: Introduce BOOTSTD_MENU to control bootflow menu
 build
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Sun, 20 Oct 2024 at 17:43, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The bootflow_menu.c code depends on e.g. scene_txt_set_font(),
> which is only built when CONFIG_EXPO is enabled. Introduce new
> Kconfig symbol BOOTSTD_MENU which depends on EXPO to prevent
> triggering errors like these in case e.g. CONFIG_VIDEO=n :
>
> "
> boot/bootflow_menu.c:158:(.text+0x8851): undefined reference to `scene_txt_set_font'
> "
>
> Make the symbol depend on BOOTSTD_FULL as well to get rid of
> the Makefile dependency workaround. Since BOOTSTD_FULL is not
> available in SPL, do not define SPL variant of BOOTSTD_MENU.
>
> Fix up bootflow test accordingly.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  boot/Kconfig         | 7 +++++++
>  boot/Makefile        | 5 +----
>  test/boot/bootflow.c | 3 +++
>  3 files changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
