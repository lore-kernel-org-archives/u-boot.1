Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFFDD11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 07:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDB6383923;
	Thu, 27 Nov 2025 08:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IGlRFKtV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE068397D; Thu, 27 Nov 2025 08:39:36 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8FE836CE
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3ec6c10a295so130008fac.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764229173; x=1764833973; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9hC/f1pVph+gt03joHrsMc8vjApBtlM2VU8nvlDqZSs=;
 b=IGlRFKtVSWj9qoATcrSKVZ0XYtH1FX/rughjx+w+5I8ZKn1P4dqrm6CvC3w8a0JF7F
 xXBhhsh+Ox9cFUZuklW4gtfE5Wnd/UPn9wzp5ecj/KyfV1nKMQhA3q6vmIl4I5X+wSYo
 eWoUOpwli6K2iM7gU7r7sDZnJspoO+VXs0As7iHKk0VL7SrQWinOYuT2UurJ9k0ZQsvG
 ijGe41uPWcBeimHuVzmflYCeqnb5Zpp0F2NntAiuwCAszlbb6HBayuiuUh4WtYmRA7Cz
 W1N6oO63oO+SGDr0JcdqwKyQ2OkcMpua3DFc2QmSQPBdCy+SW1wz4TxSzWlxYVkP6RWR
 qLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764229173; x=1764833973;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hC/f1pVph+gt03joHrsMc8vjApBtlM2VU8nvlDqZSs=;
 b=lILaWCq7pcmSqy/G8sO0C/rqsbQkyKPjW8zLBai1zxdzyES9n1kphrI+E/QUz1ymsP
 v4Bti+v5sCmJigL7qZBJj7JaW1ttEH7npM3KfD8Nn3MuX9yjOHdmU87nLLzJs34Ar+v/
 h3/R9Xjwl/kN7nAYmBCM1ocpqa5K3NXhP+pnuFnuQxPyswyRirGzKeuBOuyLX8m3YmPJ
 nihYvICvtQbb0Cd3VW9/I6Ju9VQdq8sxZ1D0q9pIbzMgLhUHfY3ioTpDE58YDtOqcRHd
 su8aBb34GS7QMSiZ1sef1oz86G5mT2MDGgU2AdqDuFxZPRmlzl1b9wAkTZS70z6+s5wk
 C6HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6EwZWDxpDuI+Zce4E2SqJRIV3NVWd1eresKjmP4zAkPq9nDOZxr9MPiZPRZ5DZlU6gCbxJbc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8xn8dh2/+JHYFzZC1IjWPb+8/8AfTbcWfvHWf3TDa5cPEwkfF
 VRzeOtE7TrEEHLEP7efEouHE3PNaLhrSjoiK/6N/+Vkax0QU+O1WWHxu4CYlUuG2vufjSRgiC4I
 vjXN/yMqJg2IQrVhWuamcfoaIxYDL6mM=
X-Gm-Gg: ASbGncu+dRCPPvwgpyJj1R4Bl/WxywIYxZYJfxcHBw5H1bOkCQbq8sgonZNMqZWpK0X
 /N44DqCs/4De9VSYQ+NzoVdW5k3QgjqBkNWC3aL3G2cX9cL7oZZ2Yvx0A2Gb9+XyXcVR6ZPezjg
 rRzZIwsyamFqQJij5hqWymyd0U7p7xsmyAayrsL4yNQtLrmxyp6EODg09ijvgUX5K8S2jCaFBAP
 drEJLW8TYOKToLYoyZRNYX16gqXGZRFR/XObTvm538GfThQlt21OS/41RpU3SYCzRHnpTY=
X-Google-Smtp-Source: AGHT+IH9RmQijHA8aNj6KJ9CDiD1hN+TUj28ZAYk6LAk8H/PtEh14gfk02NlgPPj2Zovrbp8dV0SOS70DMRHMrXtt4I=
X-Received: by 2002:a05:6830:2690:b0:7c7:6e32:dc7f with SMTP id
 46e09a7af769-7c7987e60e5mr10125593a34.0.1764229173441; Wed, 26 Nov 2025
 23:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
 <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
 <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
 <CAN7C2SCSr3h6dJLEXrUEdvAHQYyEfo3jWtkUkNccSWYTv9M7fg@mail.gmail.com>
 <0c42e18e-60d7-417d-9b83-dea8ffd4a362@siemens.com>
In-Reply-To: <0c42e18e-60d7-417d-9b83-dea8ffd4a362@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 27 Nov 2025 15:39:21 +0800
X-Gm-Features: AWmQ_blrlQtj8EepUtFyKPmKD-ztjnc_UFEQAWEzmmVNf7K3AzK_SQUCD8kdJxU
Message-ID: <CAN7C2SDH6g0PgDUsu8hEnEA4yr6z+YA5afWhK9-D7-7wBbe33A@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, 
 u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
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

> It is ok to work around current issues in upstream, but we still need to
> fix raw mode loading - or drop it from the tree if it has no value
> anymore (not my decision).
>
> Jan

No this is not a work around it is SPL seeking change from first place.
From the beginning, u-boot-with-spl.sfp is not supposed to exist
after 2025.05 or 2025.07 I forgot when the seek change from combine
to one out of three.

raw mode loading works, just combining two is no longer an option from
first place. My understanding as such.

I don;t think you had encountered SPL not beginning printout aka load.

Brian
