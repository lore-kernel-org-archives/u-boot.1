Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31118C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 13:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53E8280E9A;
	Sat,  7 Jun 2025 15:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FkbGR+zo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E6781F0D; Sat,  7 Jun 2025 15:59:21 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DD1807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 15:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-60727e46168so5177211a12.0
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 06:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1749304757; x=1749909557; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Brz1IMk4Dobn3Xtca4Vas1OoCM08TPLFE8Phhk69LVw=;
 b=FkbGR+zodlUCprpkQ1KYfBmNJ9uB/yVae9S2NyecBpnajJrWrVxvVA2VTvVEnWW047
 NJ12ktmWwmJfmVaQDpZEzljGm23a9sDfzT6ItD2Ddqj/WDMBwpaprXGk1sMBuXsg5ZDq
 /NsoRg5fiVD9zhA/uiCwsB4E5TghP4XF5wTvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749304757; x=1749909557;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Brz1IMk4Dobn3Xtca4Vas1OoCM08TPLFE8Phhk69LVw=;
 b=ZStL27Hgsl0bq0nodh9rXRMTrz91J7xMGRY7S582BJJzh60WrlhbAxG6baxi6rxgL0
 BmwDJujFXgZbQjfzbQ4aQ5VjshiXcR54Tq9ODU0TLk4kQ5NgHaCRALuLT/lYnXhau+qa
 IOJgtP9OFnK/jM65aY8ZwS5RH3rmMngYe9ghHZgx2OKw0mFrKWfv4WsV2ktI+tLNy7Ny
 mQE2d2OdJPm7X9lw1LCZc/q4h39xgT/HxCpzY/W36n0r12RrIrm+mHhVQEvm5YeDwqjL
 TkS4OVGhGb8nYRcXDNGl96WbriE4m8EG3U9twZRz7WmpiuvX4m7cDqagwl1nvysI52WI
 ning==
X-Gm-Message-State: AOJu0Yyz9nWjvZ19pa+3G9XFVopkv5cE6pprzHtLaarTZxqXPFf/l/Bd
 L4XG0WkgpWP9iGAbi+sSQFdn1g3jjChA3OZIST1Fvlixv8IbM7GM14h/rwz5/56TBEOfFJKI4ZD
 YW0rLRi4fA3gkjOjGvNrwzVYdl6i4DHb+lH+7c5GW/LkOZHpSOu4znQ==
X-Gm-Gg: ASbGncvTt9GQPbAXJLY/FAU6+1I0ytD8BdPJ9TK5qZ0F/owCCDGqI0rbF6saX95M4M/
 O+JRH534OiZH0cuUvnc75LJTeTaD/m+XKyjITEn0t7tpFZLixS4/S1T0m5MX2EkM7jXbxsEERtl
 3WzuicGsXNn/tHt5gwyqCcHEJzhB19sAlwtafT5/YXZX0HDqOyjbDPrGg=
X-Google-Smtp-Source: AGHT+IFbSRduQdSnQTTgGRlzlYuGV6bv4d9PZEuT+7OdP1BSGcUlfTPcUWvfxBH9xxKBQuZWB07t5R6LyVNuVMmlqgo=
X-Received: by 2002:a05:6402:1ed4:b0:602:10b6:c982 with SMTP id
 4fb4d7f45d1cf-607735137b9mr5706859a12.12.1749304757558; Sat, 07 Jun 2025
 06:59:17 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Jun 2025 07:59:06 -0600
X-Gm-Features: AX0GCFse9WBMpqeO3XxrJooxTWnozRHy2DM9XILw5FmY_QEpSNyrlBmACUSoPeY
Message-ID: <CAFLszTht55_Wv4se6NT-zkVgMseeSEpnxZqpfz1N2RC7bxVQ5w@mail.gmail.com>
Subject: Away for a while
To: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

Just a note to say that I'll be disengaging from the mailing list and
irc for a while I work on some specific areas. Please send me a direct
email / irc message if needed, but no promises!

Regards,
Simon
