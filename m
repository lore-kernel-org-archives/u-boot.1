Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C42CFD2F6
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 21:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38774838CE;
	Sat, 29 Nov 2025 22:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fhodKeb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102CB838E6; Sat, 29 Nov 2025 22:24:04 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA39983759
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 22:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-37ce27af365so25348331fa.0
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 13:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764451441; x=1765056241; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+hE7lqkeA4l1GQsB8yDEO+QjjN78CFeUIPoKqwBBDM=;
 b=fhodKeb4mXuaF8Jq+ezPJ7AzZEck+IFshN15wguNBkkzphtTVOt+R77srrzlx0XdOm
 VLn19k5i2Gze91tt1FJa8r7XU+JkEGCf/+FGTZ39zjkHtxR50/zgAkGS+G4CCsejEdnW
 inB9b1Re6itOTlDwZ/EHkxc2qPQEJNaqIfJT9EGRm0s+xUFblSczbaPb2hdKquIRPydc
 zrqUUXqESzEfRJ3qCxZeeS3khZVn+atG9vodtXni3snAEk9R3+PCE88UZzYghrm0hOtO
 TQZ/rhXcR5K1VSMPttd4w+DH6FjLMjnzXYLkGQFmO99/GpWvLW1kFEAdQsVpxSj8dWf6
 r4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764451441; x=1765056241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o+hE7lqkeA4l1GQsB8yDEO+QjjN78CFeUIPoKqwBBDM=;
 b=G55qOL/dtlc1VzOLJ3I7+oH8U48+qLHkPTDsiaDsvHZrk3Q/OZRlWmbIiDUWJO4muA
 cQ84pWgL5ThFW/aTCrj5YhXBFcbT5UNpwsIxGgB8SZ23Sl5/3JFHjbvyQgrV5m6bpm1D
 7KSFn2BzBqeQSj6brBD2bLXfafka7Q10tu0+TZvCJ+BFZUv8eh9WJjLW27R0rnS/QJNq
 LjQ1ICYEBnq4uqLuyzRoyLEgrEamtkaU999p9A3BloQlyjRDK6/OTVMs7yo5n+HkJZ8v
 /AaCisPVL9YT10Aq2FYAoT9+MDDIREqiTf3QiIpLrM8D94BGSvkIc33pE6a10ifHTaLh
 jHOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2wNbwdyKCXrLAIl02cwm7rPeoVIaAiV+np74/XtqLJlpQZLgtAVKUXgjEUqQI9AGCWLYfq/o=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6fix+yaM811oj8UrCzcqPwVFmGWdI/VDbriFEdF9jkm7B7OjV
 TBB8OXVkoC+o0Rw/S4J8Cna5JsZf1TmeRZYrrscCI+FQOj2hleLnz9Vz5i9/TydZMa4oGsQ6/G6
 tv4NQDdqIRO8iTMkRveoHbncKyz1uGq5Z4h2N
X-Gm-Gg: ASbGncv7w3bCxHwerFb3cHMebLZkJsY1ICprphHa2qQGgyo99VQZVPi+qKszbDVTHL5
 +qDbS0aKy3G2gBiy6c+GmiK7bhW5dOfvALJ68AL8SgqTKzi7x1N9j+W9MB1xTfehImu1FcWlFxU
 UnnWPtTgNY39yeNLCtUlZD2iHVFveFP5i2p3cNpCaeqJP40bHhWjzrXbjrQxNhM9W15y9YorkPn
 Q0Z8/V0FcZHvbWAUsFgBIfiBIcq3Qn0Zan0UVpnkrtnSMWYuN3VjMSp8dLZY4+A3xhfr0gNDK9j
 qdju+AVh4X0TV1/+IehKARsVCpA=
X-Google-Smtp-Source: AGHT+IGA0eMFaKvze++fT8s7wYm5StDYnZsZa0Jc5a5bdgKbCEZpmneEj51pKrhYvEQCSIUg5CKOlfkGNL5o2BIMt+I=
X-Received: by 2002:a05:6512:234d:b0:579:8bbb:d61b with SMTP id
 2adb3069b0e04-596a3ef7e0fmr12402796e87.46.1764451440911; Sat, 29 Nov 2025
 13:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 29 Nov 2025 18:23:49 -0300
X-Gm-Features: AWmQ_blRO_nQ2T1liyHc_ec9YOQux44yKE7g4JUK5U13mS9CfS_N53PspGhEVbI
Message-ID: <CAOMZO5DuCQZZEHMkxYstqcwz=W_9UzKb0RTxcMmtwy04E75JEw@mail.gmail.com>
Subject: Re: [PATCH 0/4] board: tqma6: non-functional changes
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@denx.de>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Nov 21, 2025 at 5:14=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> Hi all,
>
> this series brings non-functional changes to the TQMa6.

Applied to u-boot-imx/next, thanks.
