Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E0EC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 688F1806D8;
	Thu, 27 Mar 2025 16:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="B1Vi61BO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFB58082A; Thu, 27 Mar 2025 16:54:42 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5249C805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39133f709f5so715788f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1743090880; x=1743695680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G2rIkMwVZgxkECVDkZvDbsyM9eRUyov6YYJ+fK1MLNA=;
 b=B1Vi61BOkp9KC9AUVFyjZYw2GwrpMHj6jJthq9q1F6jslrtGxEuE7MpBp5f6FI5bcc
 UKAaLZJV2tOiok8WHoS3UYtq8NlJ7ya78hOCDAhHOobrVQNmE8gw6JqquENYMye9/FdE
 kZmXW4Lh5P+1fNxfDPt9vN7xwq5z5id60xGWHVQ16rcv8kc3e0xzSDwzUacjuFUCZD32
 DsoxU7UGU0TZwOKpcR+Qfr0AgTr8BYlbFGbV2wH8bMXBgIFGxT5uCzOO+TQS+DGVWhO8
 prUYQ11yxgcqGa0DXZ9mVRxsULkRZzxCDu8X91bx+tnV3qatbf5FZ9XvRKLnUeu3+7pG
 3Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743090880; x=1743695680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G2rIkMwVZgxkECVDkZvDbsyM9eRUyov6YYJ+fK1MLNA=;
 b=n2813q/S6VEzBqMYXL/VNmn16HWkk9dACgvC8A8H4Kuo2qYbPKwP3JBaWC5qcsRzRe
 b/VvukRheChW7bN/sNXgGyzlfcWrwcuAOf2cWNS6OkfmIoDvUoP9BajChRtX6+ajHxgX
 JEgmLGwRfidGOru34YNZWNFljQvG5STpnW7HX7DWs+zF3fwDhc+Hczrmo9BYav2I9e8V
 Oz77l9yppcOpocba+28MwYKbAhDhHc61KtUTqcpdMM0x6A774QYRgF9rnCuTQOkEJvt3
 HRKiLqqKwubaVITmQvH/CoGPyigLQmMGSo/0/L58PKJvYJmfRjfB3tZbhmaE6bTy1hiG
 LnLg==
X-Gm-Message-State: AOJu0YxxznuNeAg+kfrh6VqQiQMug2O5oE0xvNheBmWcpRQWnVXaAMbH
 /GdyO07GBCypaaAJTO4f+bjDGSk6HIorOAe2M3ZAPDv5Jc9LBcIlVmY8//1Wmzr0x7SEPzmYRbh
 HSSY=
X-Gm-Gg: ASbGncszAzbwuIixQz87rqBy5vW4VbeglEIbBYxgyy31uy9St2WaXKKe7wDHANgQMR0
 afJiH4iLc09HpFQPTWr1KNE0EsJ7Iys/e5KwwlJLgrNOLTbSGAw+YMKf5JXbf2E45rBl5MNGlJt
 rl3H9nk4F3BhMVqf3P8buIoQl09u1AiWdsQ1ilxEZ2+h+bvfQgnYbvlDXdDu5YqwUN1JntqsM0Y
 FQJu1BIDPSgDt4SKLwiKGBOpRE1F223TTp300V7LPkcs7hGQnG6PLBnr0P379v7lzWhIA7s+U8K
 /wgtqqQ7bqpTM0zfqOQ0i+J2L79pjrvzoSR+7FUP7kTO+Ba7sx9PgXAo1SjH+wactsQrlg==
X-Google-Smtp-Source: AGHT+IHNOPKWRw40/uO+u1KYyNY5iynhQoNb60VueLmrxjxtiSSvF6cobluU8R/QOfJQY0gf74dTPQ==
X-Received: by 2002:a05:6000:1a8d:b0:391:3b11:d604 with SMTP id
 ffacd0b85a97d-39ad178dac7mr3930404f8f.54.1743090879807; 
 Thu, 27 Mar 2025 08:54:39 -0700 (PDT)
Received: from somecomputer (ip128204144132.rev.hostingnetwork.at.
 [128.204.144.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f934812sm20334525f8f.0.2025.03.27.08.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 08:54:39 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: upstream+uboot@sigma-star.at, Simon Graber <simon.graber@sigma-star.at>,
 mbrugger@suse.com, pbrobinson@gmail.com
Subject: Unexpected RPi5 Behavior with Saved U-Boot Environment
Date: Thu, 27 Mar 2025 16:54:37 +0100
Message-ID: <3097333.a1USZiQ7eK@anvil>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi!

We recently started using U-Boot on various Raspberry Pi 5 boards
with different hardware configurations.

While testing, Simon noticed unusual boot failures, such as the kernel
failing to boot with no output or U-Boot reporting:
"ERROR: Did not find a cmdline Flattened Device Tree."

Today, I spent time investigating these issues. It appears that U-Boot
retrieves several variables from the Raspberry Pi firmware, with fdt_addr
being particularly important.
If the environment is saved, fdt_addr gets stored and takes precedence
over what the firmware provides to U-Boot.

Interestingly, the RPi firmware seems to modify fdt_addr based on connected
hardware.  Our experiments showed that even attaching an RPi camera module
changes the computed fdt_addr and U-Boot reads from the wrong memory locati=
on.

As a result, saving the environment, whether via the saveenv command in U-B=
oot
or fw_setenv in Linux, can lead to boot failures if the hardware configurat=
ion changes.

Do you have any suggestions for mitigating this issue?
In my opinion, U-Boot should not override such critical variables.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


