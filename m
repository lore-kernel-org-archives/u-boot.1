Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C9EC5AD4E
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 22:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4328E60650;
	Sun,  9 Aug 2026 22:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v0SzxR2VIMNH; Sun,  9 Aug 2026 22:08:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EA526063E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786313304;
	bh=ipOep9hVvLzatvHw0NTgYLpfxTvdY9EI5p2RaF/fnaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oCu/nCFebBD5+KkKCMYZU2edhZJLFhSjZdo216qQn5mnTRTXH6WriDKKrZQwihsRS
	 FRW9ZHIITvCxGxlnTJz3N6BGi4wo90ztR1dUkaLn2d+p79RFtvp/frL6lQC99z3TAX
	 Wec/S93FaZDkOCV//O1ZHSjzgHbz97it5dyM2IJTst+VGzzcGdIKiRwOFXojSa9wyO
	 DVuRLraf9hMinAP1FiCW2RckcMrO5H50C4UznnHlbbhraLJiZhJEraHGeyRjVdeGB2
	 6yRMowQcKlkAS3lskS9LKXFXou89UCCIZL6GosKPg75xcRmaOy8Pqww6YYUat+0/Jr
	 bXHSVmBsK6lRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EA526063E;
	Sun,  9 Aug 2026 22:08:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B6CF40A
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 22:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5AB640061
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 22:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZ9-AzbCMa8a for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 22:08:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0D4304004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D4304004B
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D4304004B
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 22:08:19 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6acbf97e9a1so687765eaf.1
 for <u-boot@lists.u-boot-project.org>; Sun, 09 Aug 2026 15:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786313299; x=1786918099;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ipOep9hVvLzatvHw0NTgYLpfxTvdY9EI5p2RaF/fnaI=;
 b=G9ldHMcbYFbgsmWQbq6DhG6yJygUlm5rjhi9x3f0Rtr+UZdHRjDIZ+1bKWX7CQs0LM
 vtikXyWR1XQT0wpd2FjVdK6wn53O42q5mU73OAGNovBRMl9Xs3R1al8NS42DWV5v3iAI
 6xlZnIzhOt5hpWTsCg51Xex9ReoatiJLKP/F+Sne4jIYDIOpqodr6OpOQc8hE2C9rYfi
 KExEi/0zWQED6JX2PzvkFwzWP9CNIHkcXIey0m8Seq05Iu+3uDbvyKUt9pABffB8X8l9
 HJhj7TQZgXQd2n8fy28ri6zDfYiUAauJC0kPpdFI9BrlLbCrVYNcu8f4F87p0BeMG/Zn
 gSDg==
X-Gm-Message-State: AOJu0YyQ0ae59L6+I3J69lQE1B7U8O4OMMg+6h352UhXEJR2+7CtVpPz
 7wpg8VI8R3QWAUzB4zHby5l9lCj8LUyRdWcl1rHhI8JXMIdrTFbMHtEdUlyK7LoOXjmq+CU51tO
 gHA6oiOA=
X-Gm-Gg: AR+sD12BeU23upmv2ZRQ/bifRDJmQvPsvf0ZzrDUHhk1+jGTORRsRTXXauG17Y+XESi
 2A6OiHsLK5ui6uQmiZMh+xLYpeTRR6mT94G54aMMaDhhhlDe1BJf6vY9dahsQ1pT4DHY2sPNOAq
 7TSub9Ik6k146bFgh5NubypWf1Pb/kZbStTMHBDv4qX8Iihl7o08rrfr1x1+zxP9GgjssLO9LZG
 mjqrhQ0WRRugh2e5KJP6Et/vX/JVyLTueyuEMC4zXKdoWHYCT30vdv+JFy3s1g/zAJNTN5d+kI1
 o8Dlvd8hXW9+Csh+DfoDFd8vFM9OrFU1qhQ2dkDaX7Vk2259RX7+ZB6GUMHWj98mKzHUWThziO0
 W+4tKywcgLO1qsxtHyV+Wwls4az7qJdJoM9+gcmkxACF8ZRuvPo+Sd2we1IW0wmTgsQQdzEu7h2
 FOTfXQ7m2QP15etCOZ1cEDgwK2Gt2NtoltEWpvggmw2ZDWD1tqWGItbOX+6OBS+2KrajpWMcuo0
 bl0UDXIdM5DMYSplR6K8m4uSzwh3lYJ0FF0Fjyt1x2c46SIwGdfjuPFRyYN45lIB76HYYzszG8+
 gidJ0ys2
X-Received: by 2002:a05:6820:611:b0:6b0:3b29:2301 with SMTP id
 006d021491bc7-6b03b292427mr9908239eaf.0.1786313299021; 
 Sun, 09 Aug 2026 15:08:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be475b6sm7881835eaf.11.2026.08.09.15.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:08:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20260809185338.841953-1-marek.vasut+usb@mailbox.org>
References: <20260809185338.841953-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/main
Message-Id: <178631329812.1212230.11128557399280472995.b4-ty@konsulko.com>
Date: Sun, 09 Aug 2026 16:08:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786313299; x=1786918099;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ipOep9hVvLzatvHw0NTgYLpfxTvdY9EI5p2RaF/fnaI=;
 b=OpV/iS0SFLR7wDBheDMwSB/o2LV4O1wKWeZPw4txGlK75LVL5f125xQBuXKH0wOyQ2
 UloZCYHnzeYs1dys2kJ86DlJS3h+bcgl3cI+Gzmx/zerZ2UJ+VrCoUVsQ3zrlWCb2VK5
 uoTP0d9iD94NrXsdCnTmBMJaaUfqrYpW50yjM=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OpV/iS0S
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

On Sun, 9 Aug 2026 20:52:50 +0200, Marek Vasut wrote:

> MTU3 DT bindings alignment with Linux DT bindings.
> 
> The following changes since commit d0615e4a67c8958fad4a8c39262074958f04c179:
> 
>   Merge tag 'u-boot-imx-main-20260807' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx (2026-08-07 10:21:33 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


