Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87172CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 21:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD2B84812;
	Fri, 15 May 2026 23:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SPkKPFze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE7D68483C; Fri, 15 May 2026 23:03:35 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB3F8480B
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 23:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd36614d329so35946566b.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778879013; cv=none;
 d=google.com; s=arc-20240605;
 b=K3n1tKDI209hPxaiOBFIkMlxugje8kYy50wCKmKNlLkHjVr+P76ivvw+OKOGVIzet0
 iWT8ra6i5O4HlD1MALL4nVemVMdg9JrRNyRrTMCnb65onpQWzb3tVwuHG7FGGa7yeljI
 O9QLjl3BtHR7LuV628cNkLmdrMn9z7izhxMM21Grq0KhBHPlGA52eb42N18E6tMnZsGu
 x1KWTXhhRljKVuSte8gLsmxqKuk1GLtEyDsc69wB3tIIAWzoztOHolIDLqPRc6oYlL/U
 acbVd4f6f+Ap9MTguOFQqUpfS5T9eOoGEcCKf7ZUup5zXi/Dah2aziuiFy3TNu2K5vZF
 fpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=70UuHCv45Y2btHNsZYl0znLB21PyYu/Rk6dJcrxg4kw=;
 fh=9+jZvay9w64t93Hw19m2fgKOrN9xLfjgjeeHNkkWmjM=;
 b=VVgSiPw/L+Bw0ImHcmEsvkOp5ifErTiBDG0eET3olUymR0LsKlEAhy4uzljhBZ0Zea
 NB2Xl5AUrGyXJroRyw+vD8uHLTpbNTJYgdmERdXWe+4Q3hy307D0QFDXEnzErT9OKKQe
 ElahwXMfqp0eoWpkxdNXVW7sHgvphJKWF9qNdpMr7BwIVxIsP7tuTGFJ69yskaV3OxHo
 5Iv0MmJp21JB+AzNh+xMswThTcwTZ8zztJTXvz2HZ08mWFL2kFLFmkEgmyLapWEQWQm5
 1nX+qK5yyHd87JgzyZ6Pni2nkGGh2K4Ok9ZJrOlT28lmtMDCm3qkArmGBfThuy2OLlDv
 bKHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778879013; x=1779483813; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=70UuHCv45Y2btHNsZYl0znLB21PyYu/Rk6dJcrxg4kw=;
 b=SPkKPFzez7Ygd6X8kT5mBbLHjn10Evuca3HPoH4NCursK6Hua1JZhYHlfkCWWeW87Z
 AEyK4rriT3Cq6XySC2EK0JF3MbiIfE0oT/KaF/1dw8td9M1mVyo6Aj3v7s1OhFEeYlgn
 PHsrZa1fYa9cvTkIbolNDBOTliCiK28TEmrWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778879013; x=1779483813;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=70UuHCv45Y2btHNsZYl0znLB21PyYu/Rk6dJcrxg4kw=;
 b=N5xNQIMqVzX+St0firc7NzzFyvt3Zvt8kIfYPv+HQFV6enB8VyjjosCOuXFeovZ4Tm
 KunM9UM9naZdfLt7x/7UQW5B/XGSZqhWn39t8onL+6Fr6es9n9nck3ZeSfIWB/IDuFpK
 TnCbCPIoMrWqqlZYm0gWZtiWeK859SO8qa/KlDF0ShLPMUO3EO9BNNWiq0CSiTmwXzID
 mBaW4B0bKaIHo3kjLGgwdzOnlcU8+M+Qjdw92IvTRsxX8/2q88AUvDypbCYbCmqKapYq
 0HtCKoAXdtdP/zcJRoZ1Aj5WUjw1MO5v6nEWCUKb7vEWdH/mJ1S2YRgU9vzdK2T+5BUX
 7bPg==
X-Gm-Message-State: AOJu0YxgJpP5ZGQAUNOMuBI3JyWdtPKjjX7ViENIB/cf6GgUqKBf/NDw
 bLW6fdac2kOONbiTY9gMYw4umPFvxTTkbmy5kurIMAYjBB7gKHCVnhuiGd/+zR9NDCFmH8koIWw
 Q3dXVDwwes4Nmb3YIplutlo4YDTACO0j+FatVeiJGFRyajZBxCiY=
X-Gm-Gg: Acq92OE0qbhqHy3DNbxzsdbrMPAehl989XD8CvpyfTkxUAuzmiFgVHxXp3z40z78Jsw
 t/rYDfXe+SHeldt1U7FYPxbmFLV0uucEIdlQAspsHeNdEu5Q3gmcX/HvRGWxM4hBLj3E9jzubYm
 Rs8/ggLctfit3sZjUnnjoWb2YKANdPYXGnuk/cI8OgF5O4Iudjtuw5hoBGmlegQhPb10NV3XX77
 MLLFTvHok75Uf9SlYXgM5BtJSMNsMK8/8nG2PcQOKjUCXt8hGQA2iscV4+Zk84F3eunbfqPLZvH
 Iy+7xA==
X-Received: by 2002:a17:906:f59e:b0:bd4:8b86:9026 with SMTP id
 a640c23a62f3a-bd51795bc15mr419536866b.25.1778879012927; Fri, 15 May 2026
 14:03:32 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 15:03:21 -0600
X-Gm-Features: AVHnY4LnMJxw6_8BvJ8k7AapJ4k9sNToecj6ggJaKZ5J_GY60T7MwunJbDg058w
Message-ID: <CAFLszTjnL6rn_mTA+jhcrRLF0yEtN4FVwTeGGy9GeGbgdB9fYw@mail.gmail.com>
Subject: AI-assisted review
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>
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

There was a query on the call this week about whether I am doing
AI-assisted code review. As I said on the call: yes. Here is a brief
description of how it works.

It is built into Patman (on the Concept tree) with a new 'patman
review' command. You give it the series name / number, or perhaps a
patch name/number and it applies the patches to a new branch, does a
review then adds its comments to its database.

A '-d' flag can be used to create draft emails in Gmail (sorry, it
doesn't support other email programs yet). You then check and update
the emails and send them (or delete them). I am not an expert in
handling the 'user voice' part of AI, but have made an attempt to make
it follow any provided configuration, as well as to scan recent
reviews to actually create to create a voice.

Obviously this is very rudimentary and could be expanded considerably.
But the mere fact that it creates draft emails is a win for me, even
if I ultimately delete or rewrite most of the comments. I can imagine
10 different ways to improve it to be more useful.

I wrote a blog post about it if you want more details, or you can ask me here.

I am very interested in hearing how others are using these new tools
for code review.

Regards,
Simon
