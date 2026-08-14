Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD83C5DF69
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B333608CE;
	Fri, 14 Aug 2026 13:51:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iBFpIIdG2Q9n; Fri, 14 Aug 2026 13:51:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7190660B3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715483;
	bh=y4zIoeSLL4JljYWQxXzIfjR3Kw8FGyGHluL8htLXy0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jFv6MrsFe7ZnJTR6N6rkT8x17/bR4IyGJZBykeJ84DK6w/dd0u824LnoRUPwOe9Av
	 vTIJAFJc8GJND/uoE9Bq+7SDvQOBRbsoriFPSxJoRVzROyUOiUjCc70AvvOowO1XrA
	 dJ0I36/P3/3DsYlMnNPOj/9w8FUy7OotfuqyuM85IeDwBBC1ErHlgCN0AZKSG7Wp1n
	 MnoM9iHBqISrVpiLprf/A4iOp/wjIDTz61yucKWiKm5f14mgPA/9voLNsOpMDnGoYt
	 lyO+FIWM2mdg+DnUTmBizzIOcaUc1gJgFLhKYtIrZk5X7Y6WXYiXSq4S0ksLyVGcIU
	 gMIFON3xF8eWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7190660B3B;
	Fri, 14 Aug 2026 13:51:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DCCCB139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C25E4608BA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6R5s-a4BQhP for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:51:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1C06660626
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C06660626
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=kVhAhzHR
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C06660626
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:13 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7eb34c17b96so773976a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786715473; x=1787320273;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y4zIoeSLL4JljYWQxXzIfjR3Kw8FGyGHluL8htLXy0g=;
 b=kVhAhzHRvNejjvP3+t2gR5wEr9NjXv8Y0bUDHMiYYF1K6fPwL4yPnpokU4d6jQjYww
 S4ApYi80/jgOtihZZE6zvaTephwgXQOw29UDdnZ3IlvzqDrxc5x4a7ukWQDQa5H0StcI
 vdwIb04BEBGNGAzdL0Xu/+TGIcSy4MlwzuozU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715473; x=1787320273;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y4zIoeSLL4JljYWQxXzIfjR3Kw8FGyGHluL8htLXy0g=;
 b=eEGwz166EobuKXAYPLsSm3L2i01YGSb9X3aiSsRK1u3jFPuzccgeVcNeseksF+Q3zT
 /+A5GaCHOLjfwVc58Sbr9y0rBRWDuBHcjiuWxPHr6CueQSZNXZus1Qw7D3T1Ndm+OSqW
 hnoVLW+uEthnK8JSogu1fMJvHrl6TPPRbvTeqZELGflOw4aY+bEATxV4lQZbZo5hWxwc
 /60Gfx6SH2//ecRfEZ3FOo62JVUhzBoz8zAkitloHIAxt4tvEb0kgz7MBmrCf7/oAnlc
 4Atxyn3A0hu8416Bpvecne52W4nZj74iiTw8YJD9hFGyqw5lMMfKbwTdhgcHMR5HjrNH
 N3Fg==
X-Gm-Message-State: AOJu0YxIwQImVJ9ozJZlup+Et0L4BEpM1wiAyEHRuMmm9oa+UQGZYdv9
 zNFlyTuhXJAmvyfAolwgR8iheePziS8JT84nRMlaqjoNuDRzN3AuAVy2SItE8cB1HARCC4RU6Sh
 x0sHoLp4=
X-Gm-Gg: AR+sD10obR2bLdwbx41WvJ7Eb8fmtcwTKCQed2ED0T6cTYreFttn0eh07+ai0VA8PO2
 +CsrVURfi1s5WjXGr+HHSa/g30v6YhTiDI39mwjls4UHsbHg2BtCcPADy1frFPzBX6kkHSgI6O8
 0in+wfxdANlJ6OoEDnCj1xuksPosxc+sMz447FtVbfyt+cvlihjQwzBlcaaamjmjNsLkEABsLPZ
 8Jv/kmwK1Q/38u0AH9y2Zjyk5lUV7Uj22eYmc2fa7mxgHi++YYBF6+mqOH1/HdrW6ySv2aAN3Yk
 YCdLLB6UaJDXo7s1rehOJ1Mp3PIR77CJwXvUHin/4jAO8DL4TAp00/7foh51sU4x0j25dkekh8v
 Bk82bQZTgdZrx3oiNq7zLhZ5w0JwxsMhigR5Voq4MnTixVAMZcrvyj3omWRZMsCb3q2irUL2WOg
 ydRP/eSKI31ZUsUQw9CZm1jtfTjaUhKP+AknWmcnK5+/dpgv2nyT1XnyD0H8gESAc8je7fifP7E
 TIHcE8q6MdLoW+tegOig1gsyY8vzJBGdEudhqsK8FyLHf3s8NrJyLihU78kTFDrJJhYaB/SOWA8
 IN6/7pZn
X-Received: by 2002:a05:6830:44a3:b0:7e6:f7fb:967f with SMTP id
 46e09a7af769-7f3de55bd2amr4472678a34.2.1786715473048; 
 Fri, 14 Aug 2026 06:51:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86a2271sm977086a34.27.2026.08.14.06.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:51:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Ozan Durgut <ozndrgt@gmail.com>
Cc: linux@analog.com, malysagreg@gmail.com, vasileios.bimpikas@analog.com, 
 arturs.artamonovs@analog.com, Ozan Durgut <ozan.durgut@analog.com>
In-Reply-To: <20260806184548.198419-1-ozndrgt@gmail.com>
References: <20260806184548.198419-1-ozndrgt@gmail.com>
Subject: Re: [PATCH] configs: sc598-som-ezlite: select EV-SOMCRR-EZLITE carrier
Message-Id: <178671547217.3828101.9024414130103799621.b4-ty@konsulko.com>
Date: Fri, 14 Aug 2026 07:51:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 06 Aug 2026 20:45:48 +0200, Ozan Durgut wrote:

> TARGET_SC598_SOM_EZLITE's 'select ADI_CARRIER_SOMCRR_EZLITE' loses
> against the carrier choice's own default (ADI_CARRIER_SOMCRR_EZKIT)
> since defconfig did not pin it explicitly. Board built with EZKIT
> carrier init, so the EZLITE's eth0-reset line was never toggled and
> the PHY stayed in reset.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] configs: sc598-som-ezlite: select EV-SOMCRR-EZLITE carrier
      commit: 9cb44d1e960b8afe2e89e76e3c1ffbf256d536ad
-- 
Tom


