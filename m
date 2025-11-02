Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ECCCCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 11:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCB083642;
	Sun,  2 Nov 2025 12:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qp3++FBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E108389A; Sun,  2 Nov 2025 12:15:01 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C97D8307F
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 12:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso3567628b3a.0
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 03:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762082097; x=1762686897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3FJN2jGtE9y+ArbiDl63QR+D633MQH0rqHHH0sVYc8=;
 b=Qp3++FBZzWFcCS7fquPUYS8KxFLipe5+C5D5/uzDlqxIsxamdcbh3RLKdbeq3eNBAa
 //P1ok7jLnivyaA1tOrGVDtiAqRUWAfgfuKsHIGqzmOjPXMBZ29yDpc1sZMqZA0sW6y9
 +KcIbGFEeu/JuR6brnUouja1QDsOdsmNsjxqopP5ejZMeQQF15IoRrPaLCs5jFoH7gnv
 LXMBhoae8pKaNu0A/GgfWvBIE3sPyuvzp754Iymiw1wGzfXI5YvJ/ZqbVXSaCOneRkHh
 qfp3NNaVO61QziTQxZxouKWvsNi1f3HM3PSYJawnbfsYe2+gLCbEwnW0BhDAk73t6/4t
 osAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762082097; x=1762686897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3FJN2jGtE9y+ArbiDl63QR+D633MQH0rqHHH0sVYc8=;
 b=KdO2xNocpsYZLL49l83xRkE7FAR2sfB3oIiLO9YgLQo9mSpmdP3NhHf/rBUktj2Xjz
 CgOYmJoIllQnRG8GgEgeWL5t86JLI7tGEz5DcOL+FSIVV8NBTiyzVPrXbHKv/X+e+4vT
 3sCl1JRePspNHFObfLWo7gNH+jxeDSL+KP+GqhHRo/aMbREOMTz57hgrpx/mJQqmZWaz
 FddYVeaKDkEQuZUR+v4KTMbtIpqmo75F8uaLGx14s9hodteN8Gi9s/c05wU3ud4JEPpk
 u12LWQsP4N9/6v8jWAGnxymMuW/8ptQ6+NXw99RiO4VetMGmKE5Aiz4ifpP4NVFnZ3Ae
 CHRQ==
X-Gm-Message-State: AOJu0YzZnLA5Iv9HNhGY75nlfUSNld6wdIQxaSAEET8BCxSQiAUiYGeb
 i4aOY+O53HKsyNjbFQByrIZ3OVQaoMKW0dNCfZje7z/JjIcnhIqa9rDX+JarEdo32VY=
X-Gm-Gg: ASbGncsrSq93VSmmw3iP7ViRtDva/hYUbOZjV6WYKqQishjuYSytTLZWn0RlWZoZkew
 11NGf3JvY5I+Lv2OVRXdG5gjxlcOETPsQshof8fxSGx3ah6sOtDHrD81jfQHwlQPt1DLm5GV4Ss
 3T1PRYhFOcpv63oMFNOUKIja4MoWNlFsm06jIXr+Jxd6yZ51qsKLfRYBLOqFZxOQJRCqI8vbDb8
 hzDGFo5emiaXNVULS2/l0ZWX772JOYywEH4DOrzmXzGq1fjkJNottxUoQj170cMVWr0b8uMsUfZ
 1U+IIQqIHigQ6zu3eyOAXDRGVPq6Sak9kT7AP7clqGsXTKFIVhtSj33PK+8+J0xUiXmb9+fCUqd
 3Ay+HTPyJM1JGCjVVpNYCatHXmJkHKU83nsMqz94DJcT2dPYEq96fcHLx84tg5/ZghXjqSGeoRC
 uKRrBzcuSHnGuwvNRmZAtplxXd5fQcdbrpRFPm+wCoNRncu9ScPfT1cWZ5r/sErQFsPkg45Hx4o
 G0+Gp2zZplikiO9
X-Google-Smtp-Source: AGHT+IGT53ginDv5eH8kFylidZkZLQXvkYkf+aJp9UXUSrs7m27lfVUNOFT6fhu6yGampO4G8XpdYQ==
X-Received: by 2002:a05:6a20:918b:b0:340:15c1:61be with SMTP id
 adf61e73a8af0-348cc8e369amr10999115637.32.1762082097282; 
 Sun, 02 Nov 2025 03:14:57 -0800 (PST)
Received: from sun-virtual-machine.localdomain
 (ec2-13-112-158-202.ap-northeast-1.compute.amazonaws.com. [13.112.158.202])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7aa8687e007sm1303603b3a.52.2025.11.02.03.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 03:14:56 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.denx.de
Cc: Ssunk <ssunkkan@gmail.com>, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, trini@konsulko.com, Takahiro.Kuwano@infineon.com,
 marek.vasut+renesas@mailbox.org, pratyush@kernel.org
Subject: Re: [PATCH] spi-nor: add support for XM25QH01D
Date: Sun,  2 Nov 2025 19:14:41 +0800
Message-Id: <20251102111441.5136-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827105854.10746-1-ssunkkan@gmail.com>
References: <20250827105854.10746-1-ssunkkan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi all,

Gentle ping — any comments on this patch?

Link: https://lore.kernel.org/u-boot/20250827105854.10746-1-ssunkkan@gmail.com/

Thanks,
Ssunk

