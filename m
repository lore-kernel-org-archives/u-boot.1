Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1381C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BFC38786A;
	Wed, 27 Dec 2023 08:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k8vydKKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A7E87884; Wed, 27 Dec 2023 08:55:40 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9BF1877CD
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67f147c04b7so46540826d6.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703663736; x=1704268536; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1RQ5OSyscJ25cBn9YQaQxzbzopXbVBTV2DMipZtJzwo=;
 b=k8vydKKL9MWqTlOLFDl1vi7MuP/nfo1XDTvpvMB1lStp3QQ3GubtCeIeC0ScghWLz0
 7oDQxRMTG5Ka7GzwE/7myPVMPp3cSuboer0wqCHUXmw4IQqkdDxST5AFfo3aaB8q+w8k
 osPdtBl/CAjbgjXrKVMIRCKzu13ceJ7LS4EtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703663736; x=1704268536;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1RQ5OSyscJ25cBn9YQaQxzbzopXbVBTV2DMipZtJzwo=;
 b=Lvh3hEXlDXbMrICT/dX1j+evwBCnzGfnUne94t4pgZGBDWr6lK30yKgpvFFgMJcwYu
 nepGevWh0ZNAflf3D/kux2bQE6LYyVYUjHLp1t4kERQfkVZpcwhDddE54WdACL2tKjSu
 anpUq0t6DDweWQhpcqaX0mWERJlGCUKC8e/Tfm/wgjlIbMpCWzlkDdI9Wzd2Rm1l9bMj
 Y0IDB4XKlQN3BDstckhjoLh9gKKH+s+gt2Dyh7ffzKxnvtJFQ1+2ltb1F6PkSBQd2ogh
 A2QPRd5kQHtChmFn6O33DXPWpAlWOmemTSTVumBJ02GTsCdvydd2wgOoXecIYsWA1xD1
 DmGQ==
X-Gm-Message-State: AOJu0Yy9QI7yYz8JGkS8o+AelqD++K8wjQ8ogZdtxLU8flk+gYY60+gE
 DzpyeKimEPc8VzHU2mKxlYAY42RCrtcvKSBAEz2YnQznPBh7hBWYLat6lxfSlsQV
X-Google-Smtp-Source: AGHT+IGXcLKVZCNwwd/zTDokadyo8qaoDsHAVzEkPpliItCTuIo8kT9/ZG4bIn2M1c2SQPUC3JhIcHK4JzWTUDD/et8=
X-Received: by 2002:a05:6214:19c9:b0:67a:a444:ac7f with SMTP id
 j9-20020a05621419c900b0067aa444ac7fmr15155201qvc.36.1703663736682; Tue, 26
 Dec 2023 23:55:36 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 07:55:26 +0000
Message-ID: <CAFLszTjvFWYNJGK_cAo6UuGNcBqO1KSGWUS4j58DHM_fu6V_Tw@mail.gmail.com>
Subject: vexpress and DM_SERIAL
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Kristian Amlie <kristian.amlie@northern.tech>
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

Hi Kristian,

Do you think it would be possible to migrate the vexpress_ca9x4 board
to use DM_SERIAL?

Thanks,
SImon
