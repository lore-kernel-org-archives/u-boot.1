Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86D0C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C12306078D;
	Thu, 20 Aug 2026 12:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bd-SGL203p8j; Thu, 20 Aug 2026 12:12:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787227947;
	bh=9dwpj23bS9OuT0ux/TqLqzYQdlBtRS2mAyOTSnmw8MY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vLAdbExV9DxKo6eS/kdkZogX/kjkbVti3JQyvY9H6QGjJphPkrxOPxDsSDsXGx2ZI
	 RLmkBs082UNugHAtkyjYEM1HrwCdatEuTP7C6W1/iSmhxIEMt2POu5NBDnkQeJW8ez
	 rnTuhp2ag07U4HCREZRZ1qLf54IMq4c+vCyZV2GDI16+gyc2y5DDqJU8Eum/rQ8ynz
	 0BeDrejyaRtxeBDKJxW2S/D/TNQWBzbhxafzVWQx0IzMiibFelTokmdFTUnjRItwYA
	 QwcJU0ESZttyMHxtoFc4O4DmskVo0aZT1I1dRyRxSTCYs5vFGGroLrhb8zDTotSTKy
	 DGAxxtOLhr6iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37EAE6076A;
	Thu, 20 Aug 2026 12:12:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2242129D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07C6180CC8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:12:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oNF0vLbP34Dw for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:12:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HT5eHxoT
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 09CC480CBD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:12:23 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so363555066b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787227941; cv=none;
 d=google.com; s=arc-20260327;
 b=kBplxpEP2dgMfi6WMXVj7Fa3XFWL6b8uGq5Sy7Fpe0/mofsaYJL3aykdv0X4DJoVXQ
 +xtWP3N6MCpnhwi8sAQfItP+FLoIbfHXXJBnQIwhE9oXxjSXRw0amEFyuXgqQMk9+tP0
 I+DBxlVQC3G9I6GdJMFOOMRTc5OmDMKtqE9OZae+Nxxaz+FkCBVs2w+WSwnhGfBqlbwx
 waggQxATNGHHksvzYNHVyizOdc5/qZzg1PRhivEjx+KDVZGaso9xBPwNIRGtEaKPRRHq
 DTatnWq53kHF6PO/6D+Mns9jyDguJ79NHDpBSdoqig7nbxz2HLJ0hvFTKsVgdjjicH3d
 Y8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9dwpj23bS9OuT0ux/TqLqzYQdlBtRS2mAyOTSnmw8MY=;
 fh=Bwjok4jWsPwFzEPPOJOguv26ANoKPtuv9PCfDq8ap3w=;
 b=WDgGssZ3ZBGvB4xJFVv27xO49pigEaBXsnTDN9qW5HmPypsFdigVAhFwTKB1dAQ9aV
 jvpHK1FborZF/YWMPhCjDdGvewZ7zFGuSRzchDJJpjSHJB94xbAOBnCsCL/JaaJEuCXk
 F120my6i2KnbCjFm3tIKo7rqFSP1XMbK42KBdx2xDTYrA9J3GA8kx/pO0Asf/mODfEdA
 YOrIjjdIV2nflxUatZKqCkYgh5SZ7JoX9SLnsjbREkDZtd7RgAjacxJ6aqOn7EZtvarX
 PD0R6G1ljh3nqgOqGBTaDihJZlIR1gjAR+yI/w9ZXJBiogK+XEeTJlHc3m97aGQVmi8X
 r/6A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787227941; x=1787832741;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9dwpj23bS9OuT0ux/TqLqzYQdlBtRS2mAyOTSnmw8MY=;
 b=HT5eHxoTkoOeg9TGEWEUlgrJbtGzHXfPexlBuK1dI6Az/UMUeuKO3JOOXlWPAVbN9b
 r4gJl5MGEcCIFwuKCkcQr+fXWcBFSJobSnWHTtcdU3fcK7tTVRI7EERvzLj5Mjq8lSwc
 J18WPqKWVaAUygto77CiOVmQDBE5ASlSBkdT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787227941; x=1787832741;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9dwpj23bS9OuT0ux/TqLqzYQdlBtRS2mAyOTSnmw8MY=;
 b=V7MIrXduLd9QVlTIYZ0foLKBdyBLjQpSXbtl45BV4XWQWyx7xgUcBPh6g0CbaJjCMK
 ShPaQ82P7uECyq8jn25LW5ZHz817oVrorUxxvoXQb4aRT91MIrGhVFRjvTuKkmtzSKKI
 WiqlKO/d92JTD+3GO2YIhyQsV+lIkbMMd/Ay8g4M951ABEHQn8kXT9fBsRJUpMJMznkn
 hWBr7Q2qO8Qb6kYEV47naW2BP/ez8n2x/a7xwbNiYbG8bsIB9qwCNCGZaWFl+yLkZQuK
 HFtkcE7mmdzr9CaNbiXc+uM/Qqp80ahd0O9cae6MZAPrYh9YJGr0YocV66IH5YWvoT+k
 5dgQ==
X-Gm-Message-State: AOJu0YyZak3ON2KjuqYmXqRsb2Tbtp/zMHiyMnTxoNwxEQ5sYplMJ23e
 lmQHRg90iVfeEMdPX5EGwWR5Fns3Mij/+u+a8TUoron7n64RhmcwHW3iFBt2hWZAfpQBgAGUQjl
 trVTYvLgi+O1UHODx4BnTRyzl2b3iFdOfp7ajLsjv
X-Gm-Gg: AR+sD10zn7v/RJseBpz5vRXaUTEp+zcc1OzPh2rIUZWscfioNMPlCE4IhdgPH7DO5ox
 NzkPBkhyuhAfKyb20uBJiab4tg62yKzmOOCeV6LUD5frTpwxBlEYZ0j9AwZ+/LTsB9Af3yj39U/
 mT7b7eVjx7ADBhQctBwXDD4jHh7DxtNb0tUdYZgLaWXy403TEX3bxAlQgjiQwvmX9ec9Uz5pj1C
 CRX0TEWAhczV6lhbG1McNfAR9bSkRwZS6eRYz06Ws3DtI5/23XgndQaKswZKd/kcK2n/NoTMYjH
 6s/4LtzoceFh9oS6woX6G4gomf0+aKgyt6q+fOI/wgA=
X-Received: by 2002:a17:907:d21:b0:c16:8931:245c with SMTP id
 a640c23a62f3a-c242e367ed4mr812954566b.21.1787227941216; Thu, 20 Aug 2026
 05:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
 <20260811-b4-reset-edl-rebootmode-v1-1-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-1-2e15adc156a3@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:12:08 -0600
X-Gm-Features: AcwNN1UJLmwNa2xiLixabsGRE44ePj2uJC5JH1P4pgwDieN9eMjiY6KgSsTQ8xU
Message-ID: <CAFLszThSHebH8gxG8Gk6pwC4u4zRGUrRAJyX=63LrBDBg-wvfA@mail.gmail.com>
Subject: Re: [PATCH 1/8] reboot-mode: parse up to 3 magic cells per mode
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>
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

On 2026-08-11T05:18:35, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> reboot-mode: parse up to 3 magic cells per mode
>
> The reboot-mode framework currently stores a single u32 magic value per
> mode and parses exactly one cell from each "mode-*" device tree property.
> That is sufficient for the existing backing-store users (nvmem, gpio,
> rtc), but a PSCI SYSTEM_RESET2 vendor reset is described by up to three
> 32-bit cells: <reset_type[, cookie_hi[, cookie_lo]]>, matching the
> reboot-mode binding for the psci "reboot-mode" subnode.
>
> Restructure struct reboot_mode_mode to hold an array of up to
> REBOOT_MODE_MAX_MAGIC (3) cells plus a cell count, and make
> dm_reboot_mode_pre_probe() length-aware so it reads 1 to 3 cells from
> each property. dm_reboot_mode_update() now matches the backing-store
> value against magic[0].
>
> Existing single-cell modes (e.g. nvmem "mode-bootloader = <0x02>") parse
> to magic[0] = 0x02, count = 1 and keep matching exactly as before, so
> there is no functional change for current users.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> drivers/reboot-mode/reboot-mode-uclass.c | 28 ++++++++++++++++++++++------
>  include/reboot-mode/reboot-mode.h        |  8 +++++++-
>  2 files changed, 29 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
