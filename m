Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAD2CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 16:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE5E8323A;
	Wed, 24 Sep 2025 18:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HwJhuwzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1A3835B9; Wed, 24 Sep 2025 18:29:00 +0200 (CEST)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6621B83071
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 18:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-62ec5f750f7so11840870a12.3
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758731337; x=1759336137; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=r/pLshWvz1/2dwdi7AFrb5awR0590v/kOU7f16X23T0=;
 b=HwJhuwzmj+Ae2kxWMo/b+rKuh1VT9wo5nlTGItEW8NzsYGFrwauguARphkWvI+UNrH
 gQwPl69mzyy7bDsHRyVuSv4OtXZjVflEhpfsQzjAV9Cmfjy1yroygV+Hx3vt8bHQqYoL
 ijJCwOvVIXAdQomzOq7jWaIr7Qzy5DEKCR600=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758731337; x=1759336137;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r/pLshWvz1/2dwdi7AFrb5awR0590v/kOU7f16X23T0=;
 b=YsCnoiWGQ6v6nrFtC5ZBV+F++6YtI+PH/AjUSqhCYDjvRIEkfCj1lD/pHkCPE0MD+J
 W8um3cxpboRXr76dpg5Q/+KEXZGRlhtIBdl1kILUx3HBpU/RWQC55Rp9o0mQ4li+s11i
 q9/gQkRHo8v9Gvz1I7Hw67+BA2FWiOF8tkI1yxvn0hP5Sd7NPvFous2jXJgpCofog0Lk
 BqVs+Oj2EOVeOMmAl2xPbzMTm99C/YiNtYhyDMuuEchqDEWeHwDThIelF+rnnO3R/PQk
 cImY0MUQHyu/suzBjy56MKh21STDKtMwALgnkfR96qTDlvoNPZP2slQ7rmMGNsddFtdT
 nZbw==
X-Gm-Message-State: AOJu0YxkaXe39z6SVYKiJ/1OjIkJRgkIJ2vi1Mv9hs16JAf3AnRmh8PV
 zjeX9XrScjIUNOrjCigVvVWSTMr5DlNGrPAMAsZqiCZ6yObHtUiLLBVO/xcd6/oMoyfZHTfhz8s
 ovZXBTNsvyByKhbPVXpl+M3wcO2gDNFWisHYMYbHHDhDQOukZ50r7//O8DvA=
X-Gm-Gg: ASbGncuw8v6qNKBgYb1cO1Dkhs6MTHsZeOpdFS4LpMNeHW8X87z3QqCByCKxTbvUHCJ
 A69bikQWhy0O4iU6sIJ5hKwYHfZ7+7ajO7Bd+T6CG5AR5vUaJWf2dojls7eVAXaXO19KBM2jckP
 PmW2N5qsEqqUKkZVPlcIJqKhB/v7Jfkht+PU5qaOp3O2A9PfsqqGViNjfMS7mPRPhTKHwpvAqGI
 gooOw==
X-Google-Smtp-Source: AGHT+IHeZIIEFqsffpOBWBOxjkA/koaKHcc36zgDioYemHW6u7/Qs49VNXzaUKW02iCMx85YMeiyyPRuKdJ1vJKn+nE=
X-Received: by 2002:a17:906:181b:b0:b2e:4504:2cf0 with SMTP id
 a640c23a62f3a-b34bbbda1d0mr36395966b.42.1758731336865; Wed, 24 Sep 2025
 09:28:56 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Sep 2025 10:28:45 -0600
X-Gm-Features: AS18NWDRK-0gvXJ2i0oTzGFu_UfZmzEJ2-eE4im6e2j3v8NqMg_j_gthz7yadq4
Message-ID: <CAFLszTg1=XAnzoBEtduADXLS3xQxeNh1Dn_77Dc_V3bTUhhFzA@mail.gmail.com>
Subject: Bootstd for sunxi
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

After the discussion on the call this week and Andre's suggestion of
putting FEL as the first global boothmeth, I took a look this morning.

I created a new v7 series without the 'efi_loader: bootstd: Drop
bootmgr for sunxi' patch.

It seems to run OK on a Linksprite_pcDuino3 but I'm not sure that is
enough. The FEL boothmeth is first, which is good. But Heinrich did a
series to reorder bootmgr which hasn't landed and specifically I had
concerns about this patch[1].

Given that Heinrich can't make the calls, I'll talk it through with
him separately and reply on this thread. For now I don't see much
benefit in sending the new v7 series, but I can if desired.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250421162555.1200687-4-heinrich.schuchardt@canonical.com/
