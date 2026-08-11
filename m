Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A0EC5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 22:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D448181196;
	Tue, 11 Aug 2026 22:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yo9gGLdJL7Ed; Tue, 11 Aug 2026 22:50:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B86981191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786488620;
	bh=PL53oChTtjkT5umNxtNdo+q/1QV/JL6Kil+j/loVnbE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eMn3/3uEi6adl1vpYcv9AWyh3jMe36FbbC1b63HZVeH3fRdcYJwTUY3nRNcb0qbKt
	 u8LVzal7sb/Jp8xJ79c7jew6RB40QvGeLXFUxRTtOvOJI2wA6kebtohQoMEER2UvDO
	 mburYLh0AeZAxEUvjOfbFS9eVR4ONVQwrSgtwD1L7SqTCceobGIjcTmZVhBt94NCwO
	 U1vV8eb5Ow+NIjfJuqeKk/RjNSvWwejrgbDI9j2YHgaqiICQVxh09WWPz9xoXDll5F
	 VZgfmLc2SIESu/QYtR3iG5IsvG+qIfPh9v90EeDdrUFbk1WAo808jhgbiqUGts1c6J
	 rQtS0xKAaZvcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B86981191;
	Tue, 11 Aug 2026 22:50:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D4B1D2E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA02E608DC
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-8_lVIqCZAU for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 22:50:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 00C29608BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00C29608BA
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00C29608BA
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:16 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6b051516aaaso114120eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 15:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786488616; x=1787093416;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PL53oChTtjkT5umNxtNdo+q/1QV/JL6Kil+j/loVnbE=;
 b=OOMsh0VMI0vUNHO+4zETlljWIHfazbnH9DDgJdNatrhp65vCx3eYDNHF9Qqb2qszvt
 w5usLf5bcXwSo3q72/yi4mYTAqxSOjkN384JG1C/hHVU6uAxsWdfnMQXvHHrNVou21/l
 aMvvzx5B9bZifMefaGWES/HZzx8qvPrVgepltilkBRAOtNxaupqSLPu3w+QxCq0LyxfQ
 x21aKQbj7K2j9jsJX6jhTdt2LfTad3ONMfXo7GTtAU9blZbgLjhBkiweVeLBvAEtuLul
 r3SRKUax/kOALqUaschUmN8VB0jsnxY82jX/8ZijqLAntTK2Go2ekw0nT5aG5eScKXQg
 daNw==
X-Gm-Message-State: AOJu0YyQjPqiTVB7fBlNtNZb3cHVwmR0yJaR7dWMNrfE+7/nKRfCoQ4D
 2j1NfO3EkoSn3hf2T6TMEwWZOCtF0w5sua6dVU5xXU7/u2oVS+jWlMJMpdZgaNDCrQ4=
X-Gm-Gg: AR+sD12xQzlKYkbarMmRIOkeJX2DbOLDCoJ24J6fR56xFhfHPJnlRMgxXoh4A5DW5x2
 j8SbS4b8Doj+LeDsO/WTNdNPYGjJB30I7nD88NG7UQ9TI49CdIVS+62eQC4DiueQQkW/KAaghy6
 qhxKx4TQF04sBWWcf7f7eByOI42ihBGorn5DDPpPMowYxZQknHB92Fcok2+o97hgLD8KjGF1iH2
 orNRjFA7yJf3PZDOgnlNQllI+3hVAt/21PhrRIoohrHyJF44ibEZ5ctOx7VsIdihQgufWr5eOGO
 lVPrpjknU3TQINW67vRmdpxILsJ86OrmzCyvNWAChJPiIZP/eJviDma2wPysTob7s4yAL/6cEtV
 LZIafOI4Q64jPcJds2yPxSqgA+Y+wfNQ3okGt0crNWeHo/2Zu+6arR7qhi8yUfaIj4jmfHHtjZS
 ASaAkSjdNj1n0bRCWvPIr+TZmNtBHsWsX3kbM8TKyvhb2/myquuqV+uLwl4uJYsOdsg7mv+14ew
 LcW8LxUYIkQLxUvVhja1JjrO9ujenTbhi40SsQvW8K2sZf04AhYMjfS88gG7B9U5vOAL79mRSZU
 CiNqE7lH
X-Received: by 2002:a05:6820:8118:b0:69e:42fd:4070 with SMTP id
 006d021491bc7-6b0b251f8afmr440072eaf.8.1786488615469; 
 Tue, 11 Aug 2026 15:50:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0ad500d37sm972541eaf.7.2026.08.11.15.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 15:50:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Siu Ming Tong <smtong@axiado.com>
Cc: Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
References: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
Subject: Re: [PATCH 0/4] Add eMMC support for Axiado SCM3005 board
Message-Id: <178648861436.3127030.8077669930667905363.b4-ty@konsulko.com>
Date: Tue, 11 Aug 2026 16:50:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786488616; x=1787093416;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PL53oChTtjkT5umNxtNdo+q/1QV/JL6Kil+j/loVnbE=;
 b=cotHtTVMUeXWF+a+X8DBZTnDsAghJDtJloVHxkRJSE4+va2KGuVBfIsZ2RhX8qhYvb
 xGgDuQjTKTWa17iExylOXWaGBrkvBhNzCVUtqf8ISs7Delkjrj5b0HcEUO4daa0lOiIS
 7bmAfEhnOEl8UBbCwN6csDMTxjVKkwXPpFdww=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=cotHtTVM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 31 Jul 2026 11:10:48 -0700, Siu Ming Tong wrote:

> This series adds eMMC support for the Axiado SCM3005 board, based on the
> AX3005 SoC, which uses an Arasan SDHCI controller paired with a dedicated
> eMMC PHY.
> 
> The series is split as follows:
> 
>   - Patch 1 adds the eMMC PHY driver (PHY_AXIADO_EMMC). The PHY provides
>     signal conditioning and DLL functionality required for high-speed
>     operation with data rates beyond 52MHz, and is based on the Arasan
>     PHY.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] phy: Add Axiado eMMC PHY driver
      commit: 21b087049df1936524e0470334459feaead8f052
[2/4] mmc: Add Axiado SDHCI driver
      commit: f79df8488647a381f972d6e4c71daffa0ecc3a63
[3/4] arm: dts: ax3005: Add SDHCI, eMMC PHY and clock node
      commit: bf622c66e6dcca6d336656b10813e185709878ad
[4/4] configs: ax3005_scm3005: Enable eMMC support
      commit: f77229cb1ca1245b9383204d421a2f2f3b233eb5
-- 
Tom


