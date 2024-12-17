Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2131E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6BDA80374;
	Tue, 17 Dec 2024 20:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BUeveg/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DCC80362; Tue, 17 Dec 2024 20:48:13 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB6980288
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7fbbe0fb0b8so3813727a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464890; x=1735069690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YaRvpNI4FBD8ooeuvCEYfUdeyRc73rwYmjmFqApyo6g=;
 b=BUeveg/G7B92d20fgNr6sYPWdNRrQsjKVkj1zPQwaHpn5YbIMsF5vY/T5eSqyLvktL
 1oePqIuKYqzCnojGJm/6Wj2SnSSEc35aVZtbTBQMlI3D47abKbRy+H4A0EifG/pKG1GY
 BpZsKtSyz1Dcjod9iQxyfMePbbVcAg1c8T5QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464890; x=1735069690;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YaRvpNI4FBD8ooeuvCEYfUdeyRc73rwYmjmFqApyo6g=;
 b=gqUEtP1QiU/+/MufMYB5ECKpndARDUjBjL3Gy7v21vV1U5wViAXmNA411JMEXqbMEx
 a2nnF5nOkm824Ov0G9refAhpzQ+7Qhx/p+KJLDteLo/4SUgztPUFq+WbPfr4C+lfuSew
 Xi3rn/4EljXfIMapXwDvl1E8s423vZSgBZyP4n9ivU5BhvUOkFsFKXL7C8PH0h+gYEAC
 bES7X5NctsoRfXeUFQUCm8NsQVk8C74zB0cpQU/5T+6g2yF8LWkCbtgVgsPFkYmyYPhv
 1kSxcnICzwnbdYQiT+memB8s1FB6o/IZQQb9Dnpn2rMSAqbYvq/RicxNx3KjoViqqjUf
 4dPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+uz98swyhM8kbmele97n9VqQCIXkq1e2VCXZ0IzRIqg4u+ylozUgjIQsD9h/HCoNAo8xFo6M=@lists.denx.de
X-Gm-Message-State: AOJu0Ywj5UbOM6lz3a/bUjXcQJsFj57vL3qiARmIaXNlxACP8jicwVLn
 1/G14pnvMXcNnIE5cG4HXSUJK2COG1+b9yQrz9ldzug24TBVXw6Q04KvotcDrqWyFvQaSpyiLA9
 d59BeeDLq3q5pvXQC01/fjy6SNKiAw3aVqXrb
X-Gm-Gg: ASbGncu8iZ3S73ImkNtJnF/oTEpoD7x6pFJocqB/sLn4dgJOwr+MdroOf+KFV2w0V4R
 5WAq9XV899lxK0CYVilzb98/sKKxJoV13JQ1+nwQ=
X-Google-Smtp-Source: AGHT+IHA7l7iCiMZp7qYJiQbwJd6vRCLMTOD7F89hQpHA4cbc/fMOKQ7gZ60epTSSLG0CNMIbIT9O6nrybWYL76LaO8=
X-Received: by 2002:a17:90b:4d10:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2f2e91d93bdmr212790a91.9.1734464889821; Tue, 17 Dec 2024
 11:48:09 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:48:01 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211135418.563803-6-sjg@chromium.org>
References: <20241211135418.563803-6-sjg@chromium.org>
 <20241211135418.563803-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:48:01 -0800
X-Google-Sender-Auth: WbIQWR63cRuaOzKO_t6qmxLAhNc
Message-ID: <CAFLszTgc3Nosi6MsM8YSYRb9DV3XeJQUeweX3Mioty57ZJKmtw@mail.gmail.com>
Subject: Re: [PATCH v5 05/23] efi_loader: Update startimage_exit self-test to
 check error
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Check for an error returned from the decompress() function, just in
case.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/efi_selftest/efi_selftest_startimage_exit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
