Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51606CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 05:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9EE586C58;
	Tue, 17 Oct 2023 07:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="adZwNLlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9917686C5E; Tue, 17 Oct 2023 07:35:35 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CF286BD6
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minecraft2048@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso10974310a12.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 22:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697520932; x=1698125732; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G7OmkidNB07Kd0rMdBo6mzLsboByadGN0vuygDBxLHg=;
 b=adZwNLlV+TmQPIuBNt+5L988ySvzdhJ5LXly2R2JBzxft7D4jYDUP/2nXEfG84edLg
 9g4dhzuYUjkytPAgxkVOtwba0IiqGgJBvHvczLnp4v6c0WeBDPG9atlQHLU7p3Sc8lV5
 jeDSD7MPqZFYJ4dq9eVuHtOTU0w+PrANec4iTszAIW05hosqRqOdCWnGzbkdy5FanjhH
 SUvFI3jWEBNSes8RqND019m6IzmR2yFK/6uWO0qB2VdUkWNe3japlBMcJR1oM1Q1M+7G
 pbTwb8lkijwR1esOyoDvIcrIuJHBYGz+jdozaC8eRoZqLJi9saKIVW/Gkex0jHu7M1Ed
 GZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697520932; x=1698125732;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G7OmkidNB07Kd0rMdBo6mzLsboByadGN0vuygDBxLHg=;
 b=fQJnDYj6drE5kMkZeNF5W5vLoeKNwdgC6Klp/PjMThkvSgsLUAzvI3075JNElY4Rk+
 eE1nTtr8rbwNv0YnswHdoeJl1hi1N5o0xNJTna8fBEcRvwR5eldC5toe8eP0e3dvxt8S
 v4xk0mGTpj+a8qfzp6nsmVoZ20cgkdezED+VPJcE0UacrTqpv1hkOeqaBpW9EJiZOksG
 4R3DT+EZZoMXxVE9aycRUa14HX6UD5L68SeII9pKkX14SPSwhF4RXGjEXBpVYn/lY4t5
 VTuvVDn1l/2hNAWLXjudcsS7D4N7r3EfetYrPjrPc3dgtHHjKy9uP/ofRc4RB53yZhUY
 ZV6w==
X-Gm-Message-State: AOJu0YywaBBYd5SUm46KgaNxbsOSWXsvttLYSY99T/PWT2KmkDdmtIYf
 UPkfyRTHWaWFo2nBIyqThZqc23lCQA9cDvLzoYJmt4bEcBsrmw==
X-Google-Smtp-Source: AGHT+IFZT4cs/SFNAAzthmG2DY00GfT/PjWP4/jeJNA8QwdsY8fkrdTdQWLF345+p/XfSw+qmuHLL3ABQiuBp41+fGo=
X-Received: by 2002:a50:cc4a:0:b0:530:8942:e830 with SMTP id
 n10-20020a50cc4a000000b005308942e830mr824812edi.2.1697520932078; Mon, 16 Oct
 2023 22:35:32 -0700 (PDT)
MIME-Version: 1.0
From: Ignatius Rivaldi <minecraft2048@gmail.com>
Date: Tue, 17 Oct 2023 16:35:20 +1100
Message-ID: <CAJ1CVWj3zLjK=tJr=T73JzOyNbJgMjrPdchsxVk0bMsAPQ7d8w@mail.gmail.com>
Subject: Understanding how .config for uboot is generated in buildroot
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

Hi all,

When I edit the config file in BR2_TARGET_UBOOT_CUSTOM_CONFIG_FILE in a
buildroot recipe, how does the config statements from that file got
converted into .config file in u-boot?

The background is that we're using a custom buildroot config file at here:
https://github.com/kubos/kubos-linux-build/tree/master to build u-boot for
a space grade computer. When I added a new config statement
(CONFIG_SD_SWITCH=y) in the BR2_TARGET_UBOOT_CUSTOM_CONFIG_FILE, it doesn't
write the config statement to the .config file in the uboot build repo.

 Unfortunately the company that owns that has been acquired several times
and all the engineers there already left, so I can't just ask them

Thanks
Ignatius
