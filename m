Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6699FE93712
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 20:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F30F86CE7;
	Thu,  5 Oct 2023 22:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prp.uespi.br
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=prp.uespi.br header.i=@prp.uespi.br header.b="crTvfQpB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384E886D02; Thu,  5 Oct 2023 22:23:24 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB5986C87
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 22:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=prp.uespi.br
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=project-tvbox@prp.uespi.br
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40651a726acso12842755e9.1
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prp.uespi.br; s=uespi; t=1696537397; x=1697142197; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KuXzQPkTPsTYFLwbvrapDW4g9uhSUWNqna+/CMav3MM=;
 b=crTvfQpBHcP1UfzzWkXDlTV7gI5dJOyqGaKmABbbKIQ6Qm1MTlqzaHRUqZAODjiHwG
 AKN4GMQ3o0MOFnLJUa5IwJ5e9dz2DgXRmPqF7jycUZkWPJW5zmWQnnPwY0QDI9s0hFek
 uO9yWG+QFr8a3uJcF2OuqmB6eRqrKuuLAAeWg5YyMMXgn8FS0auHZyhoayJd2hA1n0g2
 8oLJSuwQLhTW4L0iSWeHBs7+dpQ0TRccKK1ZW4/YIQ61W7l+VI+XHGfrhFrYGpddPmgj
 u272902PxcE5vmj2kzrz/0DATtG6ffAGPJ+HQ6T2pWW5B5Z1tzVbCI80Xc0JoMk0mcBm
 ckYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696537397; x=1697142197;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KuXzQPkTPsTYFLwbvrapDW4g9uhSUWNqna+/CMav3MM=;
 b=fISe9TUBlvK+D1vRBjXvbboxfCLb2SIzrAbnChfxM1pBB8VSfwtZ2JCJmY9MdVQcQF
 2mAjTSUQPwYuM7N5f3b+kADBPXMHO9F6XQ9ydPle2nFyGtji34Zixz0NYuARgwHY9V1A
 pQ6WYYPwp9oDV138OkHiy+VsBWG5YSvD9A0tQTdtdKaDcVKAIRm6NjrX9kA+xz6dcD9a
 TRcdoojQnf2ok1NElF+Jzbv5DeMcZZJjepxtQLTM8dgIjydIvCJSGMks1mGp4wkox4rH
 5MiDmp4VZX87EnAtK4XZtfX0aeHEjfC72QdxR33Ofjizobi+QzU//u2NKgDxkaHqe+FH
 afpQ==
X-Gm-Message-State: AOJu0YxFZpNBS2H9kA/0FKE4uLl1/CDvnMbsnZmvk92hjrY5G51VcqT4
 hanhtwHuW1nuvs7eStuYF61Xwy6orbDhLV3EGA4SdzdEFOcZllze
X-Google-Smtp-Source: AGHT+IFAmUq9fuTUn2PMDYDa1/l1yidNzDq+UWwPP6HgP8hR1EazY8BIzf0Aess69mh3XsTcmFeX9qUUkiNCp+Q5siY=
X-Received: by 2002:a05:600c:2189:b0:402:bcac:5773 with SMTP id
 e9-20020a05600c218900b00402bcac5773mr6161070wme.38.1696537397234; Thu, 05 Oct
 2023 13:23:17 -0700 (PDT)
MIME-Version: 1.0
From: project-tvbox project-tvbox <project-tvbox@prp.uespi.br>
Date: Thu, 5 Oct 2023 17:23:06 -0300
Message-ID: <CAC15VHQzeob=727iTbah2uOkr0LGhFLRq4W3ZpQoPNJ4rHdEJw@mail.gmail.com>
Subject: H616 DRAM support on mailine kernel
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

dears,

How can I edit the drm parameters directly in the mainline kernel,
since the mainline dts does not have these options like the legacy
one, I saw that the dram.c drives in the legacy and mailline are
similar, for example:
[dram_para]
dram_clk = 600
dram_type = 3
dram_dx_odt = 0x03030303
dram_dx_dri = 0x0e0e0e0e
dram_ca_dri = 0x1f12
dram_odt_en = 1
dram_para1 = 0x30fb
dram_para2 = 0x0000
dram_mr0 = 0x840
 in the mainline kernel
