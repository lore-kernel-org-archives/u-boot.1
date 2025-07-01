Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C52C83030
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 00:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 894A281FEE;
	Tue,  1 Jul 2025 02:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="BwY7h/1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B2D81FFC; Tue,  1 Jul 2025 02:07:08 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E3D68006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 02:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-611e455116aso761610eaf.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1751328413; x=1751933213; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6t2S1MuPkp/okt1g1tla4x5IPRsmudDNmPQ35ntQUfs=;
 b=BwY7h/1h71dOoYcbkWnJQWRht9E96HkxsdA5mRFV1iTQDAf+/TMKlcoU31QWJo+NeX
 rZIwW6GeieHspUcrBRd0myKeUjLnq9rhl/hKGQ8aj65aelbW5CNEDoLDfjhbwdskQZgB
 XszsgDtAjRDrv7v8qx9pIfzEFQBwqQD3U2eedk8cUXGDkd3EHMmh9O+oyf6IHUwJ+4xW
 uXW88IMUwWqPaW4qo3HFZPJb9SFEiuO6Ad+rJCW5E1XMUQ0PUX0Ly/KFyCgglckD79bN
 WxjyHYU1URYc0xLRZ3wnqkDj5QMDzfG85or5eghcNjm/O6+w/qcOX4Nk723WLfCw1TLh
 HUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751328413; x=1751933213;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6t2S1MuPkp/okt1g1tla4x5IPRsmudDNmPQ35ntQUfs=;
 b=GnLq1GyrAcrtdM1JPb/zDlySnBvXdKMayawQNcrGH6m+KCpjglHNOR5KMKUZb2KUL6
 Z+4wYErNQMUP3WFDoLnCnLut21NhjgXSBn5HN2StGth7a50GxNrISI40FbzztY8fsRgk
 bTeoiVdNUWP8fSwE+2WUgZl9vdYvONo9f+sVWLOuzLun5Gmt/7ZYUxVmIqom3pTQBNxw
 DtpjfveIxcx5pjsBwE9Et7mSg/zE7gtYigUY73L8m3P7V4JYldRBAZ3QLIKEP0QeUdKm
 cbLCL+BzFY423xZbkaHNhGkNXVac+feCBAL06ejlr+wdBXiqJhmp3OA+GlNUZjpuac+h
 i+jQ==
X-Gm-Message-State: AOJu0YyB/zisK5p36gAXj1IjbBnIL5KZ+gMdGTTTlxBCPfOeVXZzfO5t
 3vTdiYwqg7Azk4kShsHyfBRa6DgSuUhGCp8uNtlAy9DyMx1+iCle7iXxSuXrjJ+LII/iDay3nUn
 EnExj3V5I5BevL9D/jTHOtdrbwxat19MeWuzNmBCWjtO/ZBZZsUekI3k=
X-Gm-Gg: ASbGnctQSPMaijcHH+2acnsmvYsP5305Y+NNqVtiEQSyo0o9xxz6sQFU0WNA6UM91MO
 eqZkDgcV7miY4uMIttxz9XBmwJB8V5JGMLSSn7zkgXyj8YfE/feKJA8prwRvVK6CjFIBM9veCRD
 MhCpvevFeAs9jlmo5792Wy60vhgapHKn25E2AsOpxWpRU=
X-Google-Smtp-Source: AGHT+IFyAuIa7YMQCC513AC03zQys1Lw9lUX+jINWcw5B9QdFpHsnRzHcyO6/x9/JzP8Rne6O6pc47k47Kf6Qs7x4aQ=
X-Received: by 2002:a05:6820:4cc9:b0:611:9bc2:7cbd with SMTP id
 006d021491bc7-611b8fc944dmr9600690eaf.1.1751328413563; Mon, 30 Jun 2025
 17:06:53 -0700 (PDT)
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 30 Jun 2025 17:06:42 -0700
X-Gm-Features: Ac12FXwHpvLqo9yWpxJIMtv_ZFh3iV5GX31BQMINWxk8JC3KTMX0ky-NguOYY6M
Message-ID: <CAJ+vNU0p4BZX-853gmcgEMzXn+es5SV5aTUcU-kzTjPZLFtLOQ@mail.gmail.com>
Subject: imx95 SDP support?
To: u-boot <u-boot@lists.denx.de>, Alice Guo <alice.guo@oss.nxp.com>, 
 Fabio Estevam <festevam@gmail.com>
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

Hi Alice,

I'm wondering if you have any notes regarding U-Boot SPL SDP support
for the imx95?

The SPL boots over SDP just fine but I'm interested in getting to the
next step where the SPL provides SDP support to load U-Boot propper.
I'm not clear if the imx95 uses a similar bootrom to as the imx8 and
imx93 or if this is done over scmi.

Best Regards,

Tim
