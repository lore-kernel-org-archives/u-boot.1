Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC3ECAC5BB
	for <u-boot@archiver.kernel.org>; Sat,  4 Oct 2025 20:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD617831D6;
	Sat,  4 Oct 2025 22:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LksPjZ+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD52683693; Sat,  4 Oct 2025 22:48:28 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC5E380107
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 22:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-92aee734585so135730239f.3
 for <u-boot@lists.denx.de>; Sat, 04 Oct 2025 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759610905; x=1760215705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+p80FRrJdNykEKPU3ohwi5HhDDUqqP4iWCIeTRvRLUU=;
 b=LksPjZ+Ig9UpFurLOO0sfMlvrZOJWAaCUX5FyUs3jTr+1TU6cR0aDqxkksh/EkQLZw
 VIpb/7/oU0/GdlwlvfEPxfVDSoAWvrjoxU+muF3fPvAIuzH8ghUyTFSNvTxCvaGMaqwR
 JLaUGrJoeLSh3JURrOraqdxXW5z6nEHTeY6fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759610905; x=1760215705;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+p80FRrJdNykEKPU3ohwi5HhDDUqqP4iWCIeTRvRLUU=;
 b=JUiLd+tIhcafIVZaW6nFlmQxaFkBYDm8MNvqJLQhQYhksLDwOp3fEHwTDUfU04iPc3
 /BeQqqt8F/2tsOpHS3TqIbqdwTucPNwgtXS4x3FknDLSbA6RoLNT0kt+6OPx5cCTpPfB
 aJ+SEAFyH56cjBfEJZSdtxsxIcxsWm5KQhZOKBevZ7UwlhehX8SOc7QM7LrVx4xJGn4q
 g9wLI2se17OPw52nkhlsRUevJOipZnCH4ecOBgWbWiDvneY40QJDDnaluW0T6FU5OI+Z
 nGLlkhWse7WR9oxVvFH7xpUKPLJoPM/b7Nfs/m0q0EvEzTH50koYxNrUOO38r04nPQy0
 3tMg==
X-Gm-Message-State: AOJu0YxL4UCNQqNTOx8O8FWuZ18Xe2KSki1JQPNvJdeWylDzen0Q8Xa/
 +CpAOstqpFe3xY5gMQ2JhPdw/bpeIMaELhm/vA4++La6umnC1HHpHDFruBXjvf4ZKKR/O2v21ln
 nu49pZrE=
X-Gm-Gg: ASbGncud09CKKQCQh0lPrFG4+uWV4bkcpMgEebVtO/pOvGbb88335eTHc6wSlwKseDS
 LMweDqYA95X57EsgyRJf60qUxEJJc2673QgGXIMGZlGhpiEDDLOJOGVcY9lbe1IIh80hBJ2t1Tl
 qgsIT0du4A5VI7ewAaSh2GonnjB4P1/KAQuLZGfKotDShQ8dcRn0u2uU/vpC/sE7Q6NLW9y3Swk
 EM6f43XNZu89takgJjhdQUfbWwJZI/o0GXB2yLa0OSBit2cXbPSPoWy0dL1AfDvoPLX/hGYnKpm
 qbH2xAlpRyOMMAAn8tTaaNtdOfzlr1OgthpoAONITkQcnuCrRhkvmUlM/lEKuL7U5Hd5WFKwfoF
 CunuOEaUZhMOvWT/DiuvpfYef15IgxMTbVXTcqNSBnUSGcnSzY5uffmwx6VUiKbOud5rf7SB8QU
 1AExpskE0YegHn0pK9JSo=
X-Google-Smtp-Source: AGHT+IGco3DO+KVYwYPLfT2aWO5vBxVjI/Pvzr2/Ni1j7A326bh1QC3yB0Fjy7RcMwgO0fcV+qZKWA==
X-Received: by 2002:a05:6602:3c3:b0:922:6c20:45ef with SMTP id
 ca18e2360f4ac-93b96977bdcmr1123971539f.7.1759610905534; 
 Sat, 04 Oct 2025 13:48:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a88961d74sm321145039f.22.2025.10.04.13.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 13:48:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251004193147.3671498-1-trini@konsulko.com>
References: <20251004193147.3671498-1-trini@konsulko.com>
Subject: Re: [PATCH] global: Add expected space between '#include' and
 directive
Message-Id: <175961090421.3677446.4034238401609440163.b4-ty@konsulko.com>
Date: Sat, 04 Oct 2025 14:48:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 04 Oct 2025 13:31:46 -0600, Tom Rini wrote:

> These files had '#include<file.h>' rather than '#include <file.h>' which
> while functional is not the correct style.
> 
> 

Applied to u-boot/master, thanks!

[1/1] global: Add expected space between '#include' and directive
      commit: dc6c80056e21a27e28e1be62ac724302ef526841
-- 
Tom


