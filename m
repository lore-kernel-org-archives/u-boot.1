Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC2BC83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65EB183845;
	Fri, 11 Jul 2025 00:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Einpv3AZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE1C8362C; Fri, 11 Jul 2025 00:42:13 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A820D8382E
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c27166ab3so869212a34.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187329; x=1752792129; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLuWL8iKdEtLbLZgq9KkFrLezpkA8v29xVsbdWc6X44=;
 b=Einpv3AZr8xGcDisby78yNA/EGkyFJFd1LnK30WVO87mnogWc6gIhE1XSUZp550nL1
 3QNqzuzkezlt9/fz0tPFcmYn5dbWWJN0cNsa6mEplOz8g0ucfH9jEwQAYCjJT2MfRskK
 IABtZ1qRELJgiRcY16xOv2nrldgF8OAqp710E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187329; x=1752792129;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLuWL8iKdEtLbLZgq9KkFrLezpkA8v29xVsbdWc6X44=;
 b=SiJtAc0+g2p6DyOpR1YQsXsdB+MFplOd4ahnAz3Pe3B2q6NPSyDGTLFXAR/wgRvT4g
 CZcZhudWAg3XB0PG45jUueheCl8tHB+V3B659E96EtWwvGOXuAN71/TgIXaiagqYTTHP
 atvEZZf9+7KjNkwpxqAk1fZu6PSKB4KhRmIHU6mwUL3bnCgC+15qybnVBsy5e444t20B
 Q8AuVr2v81BHlBdB7a9mEZ6zahSmTBuxQDmHIMJS10AnhNf8yRP/TwlZECLpkeucY0mf
 gVxhPmGa2RNehTNyrQNzCYidfzVtRNvAnicnfLFmh4XD4i654pPK1bc++Ul73kMj2IgJ
 A3Fg==
X-Gm-Message-State: AOJu0YwdLSgWadUaQgDvC2UWuZAMzhBRJ1joyQX6NlbBmCH1s9AvNz7A
 lQVHr853hk27cb1tV4LBY9b3Z8Q0OVd8s2IVe4tD9F9HhpYYzqzxMJVCJBfYeXjc1UFHOhRGRW/
 xlcEcYmc=
X-Gm-Gg: ASbGncuxPxipkSOM8M4f1YfnuEWacPDYGedL4xfOV5R0OeXDGuv4GanVnqwC7f6O09W
 IkNMz5+rpKlRY6YPvMTfL3HrTsaTU2f+YblQZhhTqLivvZqVlN2rXmOmtePd7/Y7D2YrvFQatNb
 Gr80E4S44IloZkTS7BuhekK3SMADt0dFT+U6pJUsBd/dADxYIpYiwiMARBuJqfuVPBC1iABHLXU
 M7Ri7ICPcr9h1hMjKIQpUPHXj4TArSUDywZ1clLzGQ+Fm3GxB90a/PsViceNAbDFKquTJ5zZOrs
 QhMzLuktuwMWL5bPnAsi1lTpfUMtu01RJm7UDI8g1a0vjdfGwLIc2c7k4vCuwP8UsqPtnRIB7za
 apHJnLzPlOCkSMoYrq4dRyQR13K6a5DyLb6L1J/t1vgSKQU9F+Y4HSYQ=
X-Google-Smtp-Source: AGHT+IFRfzzFz2UTOKD4YxxVwRQh8J4t6Yx0BMbpEkZg5Ca8bsqU4soWoh1HBKRKzNFnpd938sl+zg==
X-Received: by 2002:a05:6830:3c88:b0:73c:925e:c6c8 with SMTP id
 46e09a7af769-73cf9e9db44mr852361a34.7.1752187329349; 
 Thu, 10 Jul 2025 15:42:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Magnus Damm <damm@opensource.se>
Cc: marek.vasut+renesas@mailbox.org
In-Reply-To: <175146324587.68406.3781314116200023930.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175146324587.68406.3781314116200023930.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: Re: [PATCH] makefile: Adjust distclean to remove .binman_stamp
 file
Message-Id: <175218732853.2073260.6108276789420313709.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:08 -0600
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

On Wed, 02 Jul 2025 15:34:05 +0200, Magnus Damm wrote:

> Remove the .binman_stamp file during distclean
> 
> 

Applied to u-boot/master, thanks!

[1/1] makefile: Adjust distclean to remove .binman_stamp file
      commit: 39b836d898782e31961afd16769c46d7f2730858
-- 
Tom


