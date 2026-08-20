Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93242C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66146607C5;
	Thu, 20 Aug 2026 12:13:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uq-K1se-Tzcd; Thu, 20 Aug 2026 12:13:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787227982;
	bh=zZUmWAtoAQL1pYHHFA4OWpi/Dx7SanZyQIMCPE5tnv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=omdCvBPmFXu9ryhirqmCjlJMCFtfNV2FoPz4MfyjqKofFWqs5ZvtUOZs2+Fm4+Vye
	 SnI1eKjzLF838Np7MfENEiVhlq2nqA9SPo8b/kWyCHE1fgj86YqtKpUXl/poXWw6Si
	 A2mmfjRhR5OTD6jPMr/A9mJZ7DD2wRzHdPL/pJEPQ4LtH627ZBfQVBVJ64UMcRkI3Z
	 5MIf/8Cxc7BpR2ZEveBau8yjvA/NZWb5967i9yIhNhvhrspw4PWWnNhnyrUg7gYrPf
	 telPPTMYeaFctjzDCEXIH0g6Hv8LEKfUQfMxifZN8vrQFlj/rluElNbDL0xHz7FejE
	 dgsGCYMZBJxgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8CCB6078D;
	Thu, 20 Aug 2026 12:13:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 737343AC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 598F480CD8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YxsIEW7eivcO for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:13:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=W2BZwKty
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 715EC80CD3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:00 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so181889666b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787227978; cv=none;
 d=google.com; s=arc-20260327;
 b=qQ7iMBxsSM4a54wy2ydIxnTO3Tow5vNYflYkcwuRNAJNhmyolGQUIeenP5vqnG+Ff6
 FnrjIo9FQ1SRx/e/loi6kEcgXc+27f7qqQ/KnbJ5d/BMnTPRrA0csCfBGBCaIQ/ptlKy
 CiOWLyDk1pCxWM14zLwZYScNSLyStJMj6iXg0NI2aJKn+F7aBhi2H9C+cwzfy9kWw23G
 1P/KkE2OBgQiMDWX9d46eRb3sLnjLiwQYQgs7PLxhiUlf9w6mNglpubhZ0oGEQnvcpNE
 tZPtlSrA4xzuCJzA0wtkQSvVs3pMtw1sqf7stZLOFSME7VEY2XC/ypOMguaKAp+2mV2J
 2qxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zZUmWAtoAQL1pYHHFA4OWpi/Dx7SanZyQIMCPE5tnv4=;
 fh=Bwjok4jWsPwFzEPPOJOguv26ANoKPtuv9PCfDq8ap3w=;
 b=OfntD5p8fwcs6WUQkSlrEMvMWFdwPu04iJXJkIz52FY+FkL52+VmgsMPxZn1i7ENtV
 J8sGwwCVLUeqyv+nIlJfP2JOtbQf8+0Slkf/aUWBjphEn31WyW/GZD7y4uRoJa/E8B/y
 ylaXi+w4aqPjePMla//oJAjqoNnSPshxc+gHOXt7QOl889Z78ZsuKOg4+Rm/CgQPFiRu
 aQmtQnVK3iuIhUYSg/yagUQ+r2t04eS0c4Cpj0ikqS64j8bP4WjkSpWfCTtv7MyRLJW3
 rNQBu/uQlh1/5xpHomBoBJHw+805TZ0Fg5oT1Zm8OzMLZ7e/RwiCRUsWwsZNSvz1u54G
 f9+Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787227978; x=1787832778;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zZUmWAtoAQL1pYHHFA4OWpi/Dx7SanZyQIMCPE5tnv4=;
 b=W2BZwKtyR37jYoYGYopbJrd0IySLjQAxhoTgrtwg5MQTrUup/vtWlQVuGVf37PM3OI
 39+JQOc8Me3g8E1an4wLaNsaMF301LxsGbnb3zR0ymy/5wTe7qOwNrKa/V857Msa6MIv
 4t7fvhgnkLkeOP6atOxd8jfZuSivsC0q5EcMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787227978; x=1787832778;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zZUmWAtoAQL1pYHHFA4OWpi/Dx7SanZyQIMCPE5tnv4=;
 b=D0tAwvVZSfQ+MVkqUXOnRxqAZx+cONZOcMCxxri+lyR70vqe/QFSUgEqypXBPl4Vgx
 w9Y7oRrlL8y9cvWf7M/rnmWg3bSg8NFwC1X1Rw9NQrUTTMSTLTyTz40+4oH6pECMx19S
 x2vtWpSKZ+gawjU4BspSY6liRK6Gj6hs6FOV2zxhUfAdzIoXrZnocwwZhyRvjdF4CY41
 BkKb6+Los9JHI6jjFBJtwEIh0r96wgfPxumbRqddKLdX9ET1TUly+4i12A821uFONK5o
 BJi2pM71kwUs20LyQrtvMxsKA1FOwtMbPPLJ5Y9PVZhj+gDtiSB2pKP98MVJkWfxvH+S
 M84g==
X-Gm-Message-State: AOJu0YzD16/fD1UcypiiW9g56s+1BN6KjuKQKrzdiMjaEVUSLtFqIb6g
 Ol0uNMqKlrBVHs8O9XI8PtSk8f2mbVb1mhS+YGk/1CwcBTFdaVzdnittQeY7yrXIVB3NUiP9Zq6
 pEPonNthoBIlJuz3zuspxVtlVyUquPtrsVvuisfjC
X-Gm-Gg: AR+sD123oyPZx0srYtdgsQjPSr41wKoc8LEna/PlZYHikde941yxPEfPZvoFJUIxpq9
 Dl7tCxcrnkCMpO0EQLSBkUbrC+nZQFxslS4UqAmdeZpQWF2TEdnrBInDqNvktydQGcYI++1FQDT
 OJA7ND5dcQ5Ni+g3UbWVp/MQiwyiFHG9ZrrcmRoyl1b27KBkD4u/LRTpbkSMPEiZbtgQqYY0Uwp
 NuOhcw/WVYQvHX7w8VKaFfgPoIJppvJv59IZcGMk4u1fzUahKhO5TAIeVS8PzKPaUVn6+p5JxDX
 KFpob8bzvvodjzGd+ls0K23B/PyQv4GEc5xQDEayQCwrWqPk9yysNQ==
X-Received: by 2002:a17:907:8b99:b0:c20:ec9c:441a with SMTP id
 a640c23a62f3a-c244d76835fmr435847766b.12.1787227978103; Thu, 20 Aug 2026
 05:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
 <20260811-b4-reset-edl-rebootmode-v1-5-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-5-2e15adc156a3@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:12:40 -0600
X-Gm-Features: AcwNN1U1EzXcMBQTMeYjIVNwvpGZ9QVMS1psah5xsxngiCeGnGGhcEBZggPcujY
Message-ID: <CAFLszTjKTh=pn15qm9NNdPrEDG7T7J_WnNoH2eU=vaHu=6CQ-g@mail.gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: qcom: add psci reboot-mode edl node for
 lemans/qcs6490-rb3gen2
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
> arm64: dts: qcom: add psci reboot-mode edl node for lemans/qcs6490-rb3gen2
>
> Add a "reboot-mode" subnode under the psci node in the lemans-evk and
> qcs6490-rb3gen2 U-Boot device tree overlays, declaring "mode-edl" so that
> "reset -edl" enters Qualcomm EDL/download mode via a PSCI SYSTEM_RESET2
> vendor reset. The magic value <0x80000000 0x00000001> is reset_type =
> 0x80000000 (vendor bit set) with a cookie of 1.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> arch/arm/dts/lemans-evk-u-boot.dtsi      | 7 +++++++
>  arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 7 +++++++
>  2 files changed, 14 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
