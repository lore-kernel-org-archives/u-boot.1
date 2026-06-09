Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67ACCD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319A684881;
	Tue,  9 Jun 2026 14:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VWZ9sJTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C32E08490B; Tue,  9 Jun 2026 14:49:27 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D92C848B0
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6913160c9ddso6890730a12.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781009365; x=1781614165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lT4BwIZomcy/i7Vv7GRr4FZ4+ENKhHSXGrLAdbkqINA=;
 b=VWZ9sJTyxcfii3XULnAhv/up1EOG5czOzZ5qgjKLr7uJsPbS8JAz1PoBvj+DZOaKeI
 9Z91DgR55hebEDLby7s5k+N/AUByBNyeqwCbIuNbjT6qI2OmhhCtXqofv/UCGVpxl/Zp
 9T9XK9zHde3WxGj2X77OzG96+8MuYZ3Yt2V8m5z0us+VHF66acqFRHcahmvA0e3m4Pai
 wK0N3i7IdjpJesUheuaRKpeaDroOaQhvguseg+IGTq3frUL7ApwihE2ZmabFI3rJ+hPV
 q304dN7m2VE9WWaF4kMpj/pJGsAuEkKUK3Z3rZBIDW9GxRfvcPXIMVaRo5XETPeQSE0y
 3Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009365; x=1781614165;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lT4BwIZomcy/i7Vv7GRr4FZ4+ENKhHSXGrLAdbkqINA=;
 b=RM+h62euZk2NbIqsHQdlsGUc0n9uuCcsEtOqF/vPFHo7FMEwCI83mMGidU7A7Dpglu
 NQh5a056y9PKWJbNbkH+Fdt6qV+yTTlY69xIhFYsrUQLomP23Mj7Q+vy7oMWcwaypXSK
 ajlqOu3PfeeYShkOiN+K3wkop/CetkVrznIyLMizkiejAv3iWMYyR1YrmIU7KbCfK/+M
 6mHADjOiqW5IxZMfHsR4o9ChxqVrRiie8KLts+GZ4unTtM+KIL/jWS2qUhLap9vxTtdr
 si2tBRoS+gEbR5fnqjShAywuycgS0sMh4KyS4L2NL4WbGU0jSHqa0YMZpndjVYZ6RPZ9
 uXDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JQYk+/4hrCsMCPMliuMPhSNAYUOlZdpubMHrvKlO9C8xZgp6BerCvoB4KXSjWBR79wYyOMQc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzb8sXtAdpkJOEY1rjTTThP+J4pNujfrerfLR9bTkcz7EdDEIrh
 xuE5Leex66HR/TBjbUXYg6wneVr9pgGh0pwoY+Mj5qdVFC4b1i4MBEbZRCVgPM+n5HU=
X-Gm-Gg: Acq92OFqpg4CQ+Koj+4W5rO442umSZRWCR83SDHbIqboOYDuGErnNybYgEwy2GLsi/u
 WLHJDvqfDPXLiR+Iu5+qa8AuP3kftetKlye+1JA+pJS0B5i90KoR28NLOw29QbUrjKkhi6sCkbo
 QIJXfPuu/bQeHkBiE7TCohEGA+AIDwZadq++d6sESTPBndgbZoS3zjkNv+h+of+5taa9DxtOT2n
 v+Z3jWjEzgaLVW9F247eIXu6d3HicprGCYfnEldE5+2EaadIS9PJvc4mtMG3D7xvycfWGBiyjfT
 fzh5hx8/VUmYDJX9L3vh0BHZSOS/Xc/+q800r+2kREaP6XmDHgK+oZyFgXJIemZDLwshfnTucxq
 x/agq1GtswmT49LnDt5ssFE4cFo4jW/juSFdOQsb7VhYyx+nPu2xxTKtqIvC38W7Gfx2856+5RS
 FwmQBAlYByhjSBR4QtC21xKXu/q8QjuhhQ4QK6padVOB+bTGaZ6JhWHgiT4IN6bihDMH3AiDoMN
 RwL09IZ+Kr5vQA=
X-Received: by 2002:a05:6402:ea2:b0:68c:3994:4601 with SMTP id
 4fb4d7f45d1cf-68fa4c0bc34mr8803030a12.4.1781009364992; 
 Tue, 09 Jun 2026 05:49:24 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b55d81sm8689526a12.27.2026.06.09.05.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:49:23 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260526-wdt-v1-1-8236040fe56a@oss.qualcomm.com>
References: <20260526-wdt-v1-1-8236040fe56a@oss.qualcomm.com>
Subject: Re: [PATCH] configs: qcs615/qcs9100: Enable watchdog autostart
Message-Id: <178100936344.3342853.4509604492516451087.b4-ty@b4>
Date: Tue, 09 Jun 2026 14:49:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Tue, 26 May 2026 12:26:36 +0530, Balaji Selvanathan wrote:
> Enable watchdog autostart for QCS615 and QCS9100 platforms to ensure
> the watchdog timer is automatically started during U-Boot
> initialization.

Applied, thanks!

[1/1] configs: qcs615/qcs9100: Enable watchdog autostart
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c0267c6b1192

Best regards,
-- 
// Casey (she/they)


