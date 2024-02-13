Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED03FC4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 11:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0977C87D72;
	Tue, 13 Feb 2024 12:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Owh4W90b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C03C87D02; Tue, 13 Feb 2024 08:27:05 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C17871C0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 08:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cedric.blancher@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5601eb97b29so7125222a12.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 23:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707809214; x=1708414014; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Y0uHo5oJF8obb5StULaxodyFhHVmuZx/ic9dcvY35HI=;
 b=Owh4W90bkphE42GHwq3YYB8Xwnq7f87dvqmbpxK387JK1P3LjQOIeWgYQO8fzvax00
 ZoitMBaH4+2NPzqMp6BOln4ptYWUY11THkGft+7MVuvIEN5VT6l70Lc+rPoS1FRBLAWs
 lAT8nDt/UEM8P4R1lrmKIlzKFzXN5B219JfzzqnD1f62dCIuCQpsMqmhCajKxYZiX1r1
 tx62pl6hlNtGFHXHCix2MCVT1ODSmGg1VeDG9xyVx3lcFi84wOMkJoonA3Qv6XCPNZBt
 DMt7WjPMhRqvLMMv1Lq+EwhWo9eDBqW+SOwmtyrKXvjyKVOOT2ninc1vXZRFDuC51+iU
 l0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707809214; x=1708414014;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y0uHo5oJF8obb5StULaxodyFhHVmuZx/ic9dcvY35HI=;
 b=B0KoDCqu8e7TKKwWC1STmm2MC5Lh3Mdi6IYIIsDiJ54zNSM/OIZ2YZ7lnvsj1xaxt6
 b1/Dr+SwZrKwGUUaNC9d4/I5gZTT2WiHaFTeLkzjpveZeT9t1kmjJEDyq5CZvf7TeCyB
 VVG7kh/YRbdiOccsrXA2ToGrbXVAcG0xtBqSYJA/FIlsUY6tX4lOkKzeBisL6jSAHvba
 3WblxY/rQDlqyOnTrAxzWPV+dvJ4h99X6zFs+hM3Kzm6gXATUXF8kpZP+tZhP0I5SWyy
 BatlnX29HtDW+uPmi74DrT7v8Jqz42hxV7tVrJ8v9SllZ4Jm+hqcyfTdT/ud7ktKG8cg
 vDgQ==
X-Gm-Message-State: AOJu0Yyp67fnT1slQaaXzQf/ch6KfF59fZkCzbtSfWzfpZnnidXNirQl
 zpfBOooTgiDn5WoSTRzP0cHvP4PQgoBKjxhB4cv/PLVpzYueffwipYhIAQHXrIdxKU5xEKF36zz
 SrhGiEd9TWkBt9S70uToRMVKoVYguKaVHkUEm7A==
X-Google-Smtp-Source: AGHT+IE21DJNtOyOb75+QGtLyLYyoQ75qOgij64cCllEanEUox3gVncaO5n0up0o2biFlUkIt5KnZXfEfL0koRBVZ/A=
X-Received: by 2002:a05:6402:3706:b0:561:aa6:32f5 with SMTP id
 ek6-20020a056402370600b005610aa632f5mr1585281edb.18.1707809214603; Mon, 12
 Feb 2024 23:26:54 -0800 (PST)
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 13 Feb 2024 08:26:00 +0100
Message-ID: <CALXu0UeJvw5UR2MDqNAi5s8R7HT22kSYr0MMoEdUgHSff9=geA@mail.gmail.com>
Subject: Booting from NFSv4 file system?
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 13 Feb 2024 12:59:13 +0100
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

Good morning!

Does U-Boot support booting from a NFSv4 file system? Explicitly
neither NFSv2 or NFSv3 will work in our case, as both protocol
versions are depreciated and no longer allowed by our IT department.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
