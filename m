Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2E6E93717
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 20:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E0186CE7;
	Thu,  5 Oct 2023 22:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prp.uespi.br
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=prp.uespi.br header.i=@prp.uespi.br header.b="YySqSYqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9E3C86D10; Thu,  5 Oct 2023 22:38:01 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB1C486C87
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 22:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=prp.uespi.br
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=project-tvbox@prp.uespi.br
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so12377485e9.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prp.uespi.br; s=uespi; t=1696538279; x=1697143079; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kFT7Th9oeTaRTzwLxvpRH2Z9l//LNOyWytyw1LuBGX0=;
 b=YySqSYqbJBu4sqrqikz0IbfOx/u3l8Fagj1rEHdviVM4szjLF1edgoY6ypXOuXj2V4
 bfyYMOCOMD8AEE5aC0B0uPyg/yk3f9AOvjF+qAYwaaKGSYmQrCwOgtlqh413kqsb/WqK
 KPTNXMs3lN/eitJmiKMOROLN8LHHxBD+KVYTC20mfWDcUc07AU7kw9oQvqEL+4M+bMHn
 vwuYVRlJo+nR2nok7LyYicQ5788FkQZz8CGspfW5r482WoCyLtnv9wWgqKWtX9ojaYIv
 jlvVROFnL/N4rMPdAV/awk4sF+FWJeUkUwXZDzolgH9dkUjhb4ua26I8D8sG4juYb9NX
 Q5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696538279; x=1697143079;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kFT7Th9oeTaRTzwLxvpRH2Z9l//LNOyWytyw1LuBGX0=;
 b=sLOikGzcpOPlx7G3LaN+oyc+1KkcK+tbNF9MpDshbSr644RXJ3N8z5PUQPMeTZRdf4
 5pBLqjHljXCsEvsYeEG7jAHe/64sdUbHoBtS296v4EBAAlzhVgyqmAi4RPnZvOu/JdRq
 BRgw9FzHe0p+6iZy3LTREDCUzfvnqzb+661w9mD36lT3fxI8pYMipZX9dfHqZg5b0cNR
 VRi19d9KWrVQ3NnOnRBduA8ktCJJKEiR6DAfIm4Wrs+on7FDxx4xUDc2XTkE279B3Llp
 9pg75bTj61gyQEOT+P77Lk4fRQ/wtERw1JS8pCUbH5rJENm7Q8C+SHTT6TeegExh2mIB
 UrwA==
X-Gm-Message-State: AOJu0YxxqfkH9xYDOeotyr5a2S+dw8tj+kNFXKz/5BLxgKrF42yUM3Q0
 c9P6xlxdGoTzYnZ0TNv88bpxN1oJwg/8cdAr5pslnyaKjJBOA5sA
X-Google-Smtp-Source: AGHT+IEtRXMswkUSrS/QWIzHyspACkq0WmeU3doRzNMuAdMZ2bhvEtw7vHa29ZK2wBF6wn4c9HUOHbyIOVJ/LyeEO2k=
X-Received: by 2002:a05:600c:210b:b0:406:548e:bd51 with SMTP id
 u11-20020a05600c210b00b00406548ebd51mr5276662wml.26.1696538278988; Thu, 05
 Oct 2023 13:37:58 -0700 (PDT)
MIME-Version: 1.0
From: project-tvbox project-tvbox <project-tvbox@prp.uespi.br>
Date: Thu, 5 Oct 2023 17:37:48 -0300
Message-ID: <CAC15VHSqtbfP-4YZYJ71CDXryJT2s-vXF9Kj=kNT4yCEAHmC=A@mail.gmail.com>
Subject: error on h616 ID axp806 legacy kernel
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

In the legacy kernel, when starting, the error appears:
the chip id is 0x5d00
ic cant match axp, please check...
well, in the axp.h code the id is defined as 0x40, I tried changing it
to 0x5d00, but it does not accept the u-boot compilation error, does
anyone know how to change it, it seems to be an error in the number of
registers available in the .h
