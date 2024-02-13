Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D146AC4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 12:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53C687BBA;
	Tue, 13 Feb 2024 13:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JA6oUFz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F5C387D64; Tue, 13 Feb 2024 13:32:04 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5324D875E9
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 13:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55fcceb5f34so4923292a12.3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 04:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707827522; x=1708432322; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/B2gowrtG7sbbrsD2s1U5QDalm62RcVm4EbKlOJ/4yk=;
 b=JA6oUFz3mZ+TQrNJP3X85PHXCG/GlgRU/gIp9PC7hmMVrFAt7EF2kJ1xKt646PfkFO
 rTnaSEzqab1yQF3XfQbc95HP9A392/CFPlu75ll2c5iqQAInz1DFoZbfZRKmUD0SAoRo
 X3NQzr4cSWggPK/EIVT3nGSn1/jWae7X7afKjt5tEJ79RA+m3cEZ1vbFvNyYpFQYU7K6
 3SVY01Ri195F3BuXGqdJQdqYNgf7IZ7TZJfpByk18qPu+lhF04IRmZiyyu2A7bX8xIZQ
 IGthav6tL9B5gGhCS64Juxlq1357rl78GnqxQ1ER0uKIHRrJg4VIRqPxFPpB1XSFuCPt
 k4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707827522; x=1708432322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/B2gowrtG7sbbrsD2s1U5QDalm62RcVm4EbKlOJ/4yk=;
 b=gJewVLU/52Z451FKyDQzEyDmL3U8r+j0j5Lba9A8f7mvFq8tOu1ladYnUcguYlCrwx
 ACu+vSJrz6lnItJK6K8M1Z269jg9xilXDkhlTcuI32f9LgWqsvtBwQnDXaYgvgguYYXV
 s4ikbhzwOMpvYWiJKh3IppJL3V+s4rSkYHQ6llegrQ9fJG7V+DzfMnNHWVd0/q2xBzL4
 rC6IdCViHf8xRvUUd1LzqWEPYijrE0SXsAEozjjrR7FibAhIC6rYWjTxlJU5fPuu2TMN
 zSL+xXccD6RUXTR+IeA289cr6y1AnHVhrutRm3VTVjj+1Mhya0k299xJ0Dh84K/0EVie
 B2yg==
X-Gm-Message-State: AOJu0YxkSuF6L0K2G9qrLDzu2Sgg34otyWgG321qEb2FEIOW1gQRRrix
 8ql0Y6SMiTBmr8Uf40tqWLJuRMQNUejK1oWmlLaiZo3UEMfajWyUwwvvgNsvLT3FQ1KLy3615kT
 /YNPKPuLu+Xfv7yqufITHMxXFRDY=
X-Google-Smtp-Source: AGHT+IHKVi3p0VF/vDfxOrHPxy/XWU9+rPzbHItXKYOtQpzT50wFcEXwUcZzFHsYgH9oBcbcM1yMKVznzjptGrRLok8=
X-Received: by 2002:a05:6402:31f9:b0:560:bbcf:1f45 with SMTP id
 dy25-20020a05640231f900b00560bbcf1f45mr6185600edb.5.1707827521189; Tue, 13
 Feb 2024 04:32:01 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeJvw5UR2MDqNAi5s8R7HT22kSYr0MMoEdUgHSff9=geA@mail.gmail.com>
In-Reply-To: <CALXu0UeJvw5UR2MDqNAi5s8R7HT22kSYr0MMoEdUgHSff9=geA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 13 Feb 2024 12:31:50 +0000
Message-ID: <CALeDE9ML1WqE6fjtPwS3DA4OEcdA2fFBH60eUrkvH3FJB1W+LA@mail.gmail.com>
Subject: Re: Booting from NFSv4 file system?
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: u-boot@lists.denx.de
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

On Tue, 13 Feb 2024 at 12:18, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> Good morning!
>
> Does U-Boot support booting from a NFSv4 file system? Explicitly
> neither NFSv2 or NFSv3 will work in our case, as both protocol
> versions are depreciated and no longer allowed by our IT department.

Not that I am aware of, at least not upstream, there is work being
done to support booting using UEFI HTTP boot if HTTP is more straight
forward for network booting.
