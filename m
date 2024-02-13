Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3399AC48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 19:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3145F87CEB;
	Tue, 13 Feb 2024 20:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJyxm60j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E17F875FA; Tue, 13 Feb 2024 20:23:54 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29BEE87D8E
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 20:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cedric.blancher@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so7219733a12.2
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 11:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707852231; x=1708457031; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0mpqmhoEZ6w6aHFhtQZw3ClcqWF3mRQUqvTU0iUaago=;
 b=MJyxm60j+6b7wWqrUQK1x93s+Fw6VzewTrzo9j6avSgGNdazd28JlI9W1FL2CQRMm4
 gu/acPc/NrwHC40H2sJqjuxqXhxt34KgtR2Zxom/bZJm13sjBIP8JPFAV4lcf9lfWS7H
 bdQ47N99LV8oqtVVulmyi386MI10Djoi9wBdMdmJxwmLElGwGzNehawg0081VGAOnJpN
 V/NoBynGNDoxSwFfKRbzg49Lqzf17Y4YVIkxv1AyTmbRXIHp/6gjHgj+hkgG7C7SnryD
 6pyQiETDay0Q8zhSTGa7dC3CSaaSL1Zkr1ad9Gm821Fksd9EMB3LQ69P2szdyWF9qb1X
 fvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707852231; x=1708457031;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0mpqmhoEZ6w6aHFhtQZw3ClcqWF3mRQUqvTU0iUaago=;
 b=FSV8OOujHMqnRgj8Mt/NVnvIKbZoGZBrMjjTA9FjeK8dyPvBdSekOzyHn+snvx5CJV
 9m4K8ht3yjdJnt18FUUGnaqLMiUII9XYVYWEvAT/m/nkvgQGi3CY7hyJi8f/QWjSUxK3
 pWDh/NMKzKRa1TD+b0/gL0Rd0oNA4l0/elBw63d19fIq3z5mfNsXHBL+eFWlsgncUBjn
 YcgprMmqBdL7OKkQn2JG3OB/4y6a388DP2dFAG+q8KzfxB7GV6bzh1zR2zpbU+tdpATx
 zLhkYBrRl57Stvg9HiPkwTq9uD8XsfVicdOTuiM3k1H6phyvkohdPOTU4rvyFa2Si6Hn
 P3dA==
X-Gm-Message-State: AOJu0YzliZvEIQ/X7ZKgJS+P7lJiF2Njz4B3QVSpTFRj4eSNiC/0vWSw
 56ZDPBulZdYKEWXkyDRCd2gCYwf3cTbHNpQm1AfBlRUr82akDxkTE/ZhfpMcoQtJoS8CI04HWgm
 gFQq7ElqH7FIZ2rZeuSQzBV0FsgzNHHE18ww=
X-Google-Smtp-Source: AGHT+IH+csWvaMbqBRGqeILM66wvDuqrVHXqhPVasiCwp670fKv67RmerH5r0Ddhat1y6E4yHnqT7hcEUBU+LNTrXfU=
X-Received: by 2002:aa7:cf87:0:b0:562:1375:b2d2 with SMTP id
 z7-20020aa7cf87000000b005621375b2d2mr485995edx.37.1707852230705; Tue, 13 Feb
 2024 11:23:50 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeJvw5UR2MDqNAi5s8R7HT22kSYr0MMoEdUgHSff9=geA@mail.gmail.com>
 <CALeDE9ML1WqE6fjtPwS3DA4OEcdA2fFBH60eUrkvH3FJB1W+LA@mail.gmail.com>
In-Reply-To: <CALeDE9ML1WqE6fjtPwS3DA4OEcdA2fFBH60eUrkvH3FJB1W+LA@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 13 Feb 2024 20:23:14 +0100
Message-ID: <CALXu0Ufj9Vh4varugz-oG9k3ktSyPDdJ9anmHO4WqEe0qLZ7gA@mail.gmail.com>
Subject: Re: Booting from NFSv4 file system?
To: u-boot@lists.denx.de
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

On Tue, 13 Feb 2024 at 13:32, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Tue, 13 Feb 2024 at 12:18, Cedric Blancher <cedric.blancher@gmail.com> wrote:
> >
> > Good morning!
> >
> > Does U-Boot support booting from a NFSv4 file system? Explicitly
> > neither NFSv2 or NFSv3 will work in our case, as both protocol
> > versions are depreciated and no longer allowed by our IT department.
>
> Not that I am aware of, at least not upstream, there is work being
> done to support booting using UEFI HTTP boot if HTTP is more straight
> forward for network booting.

HTTP is *USELESS* in this context, and comes with huge complications
(HTTP protocol diversity, absurd requirements, which are incompatible
to filesystem requirements, and security requirements like TLS, as no
IT department will deploy a bare HTTP server, only HTTPS).

So NFSv4 is the better bet.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
