Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C9EC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 13:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F69087BF1;
	Mon, 18 Mar 2024 14:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jDm70dY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6628B87DF4; Mon, 18 Mar 2024 14:50:46 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477928752B
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 14:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29f6b6d184cso265759a91.0
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710769843; x=1711374643; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbHnrWgp6BzIzS2EyA7axRT+REq7lzfIArWsMks0eFQ=;
 b=jDm70dY/gaoR54BxdeCTpQwU2/jR/NB8iaNV+0B4JV+ez3a6DcOyhVHqdusy8DZ5Ur
 /hhfdxJd94xS1hUGPPo4Z8OmL7bpbQEiZxy3c5NjmaxTpvPhecFPtc9tyYdtVhGBOQu5
 j3Mqh5qLSDZY7ls2BwutGr5BmhNloma2YJoRHHJP5YbJUO0O8e8+S0S6jY7ANh+dB7VZ
 dwKHOLmLHzYIbJndgvyRFROk9vEbqgQNzNQ7Y+zIDKmtggR8SL2j/y/sRYMfaahaPF8l
 z7XVSWSCOg02LK6lOLd7dx342L5aGUkyz4n1S0pmh/r5m58Ska5bK/wnpogLJpq39eSK
 w10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710769843; x=1711374643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbHnrWgp6BzIzS2EyA7axRT+REq7lzfIArWsMks0eFQ=;
 b=cfIGJ37qq3qKJQGdtz7QXDXmLYWae92J618dtaQD52nmpXxTR8qqHNf+J8Q476axYB
 vTkvhbS8/LN8oGSwgf6G/EjUVOGqTbzd0GzLPhM3V4l3OVC7uRFVuNyyBk/udn/GPcHS
 CkiTc1Uo04bvxNpBcWdCRkUQQHNCBzFPaRVuaqTe9BF51iPJFphvxZRYkrYtCjfForYB
 fs890gyKpA3AqYl8YiMlV5/RVr6hB7dzD8XWbIgajKSqSLg36PGDnDSQHzL/I7ctar7K
 1huUdRnzIKT0J6TCgKQeRRF4u9+vWdEarDbeOw1aUa5y44MKS0JTDZM7WHIfIoOSbFN/
 tDOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlIj/dOTbjZ4QasymPPvBebZzNwJs2Lz0X/Jyf0Qkhwyx2GroNp66rmS9DQsATOjKgYP2RNZTYnJDans5j9Gt7eN+KeQ==
X-Gm-Message-State: AOJu0YxJo7N7siDPuargAk3DLcvJhpSfoWypy/tODAlgEUhdPPVkgxMI
 9RkSDV0TZKmDXILxHx0C/p3VE1MTEr9Xof4QHDZDg0u5bYXNr/XKVVA9JcOlYgGNs0q/qhxFO67
 vI/VQjgv91mo7Kgyx6bISQ/k1eaI=
X-Google-Smtp-Source: AGHT+IFSNBCT5uz1AMYi5Oz1HowiMFVFRQ1dFlSoBe/lALd7O2ngHrhg05nLN4bSTOnTaS4A8HJZohn0LdjPkIKjCR8=
X-Received: by 2002:a17:90a:1fc9:b0:29e:b9c:d062 with SMTP id
 z9-20020a17090a1fc900b0029e0b9cd062mr6021732pjz.3.1710769842710; Mon, 18 Mar
 2024 06:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230214133814.4173549-1-paul.liu@linaro.org>
 <20230214133814.4173549-2-paul.liu@linaro.org>
 <CAOMZO5B=EYPSNXkr=FM+iRvRYiv9fysB8DfhntuhQ_jhkKz38Q@mail.gmail.com>
 <875xxvratg.wl-maz@kernel.org>
 <CAOMZO5DBzEcga0-QGBBP3twT6imLuCv0cD6EYLOTwGN47wTxsA@mail.gmail.com>
 <87zfv7pojq.wl-maz@kernel.org>
 <CAOMZO5AMi_5XqYUodPcfiFtbn9A7P1HVn__F-BLavLqnwMeNkg@mail.gmail.com>
 <CAOMZO5CqH1OuVQDNH7+CuzPbBt9M8F7OOhDgCZZ0ad7rBfT52w@mail.gmail.com>
 <vozturnswioy4b46tp5j45tq4kv7gnfkklwnw2bipn3mi3q2zi@4f4q2bwf7qun>
 <CAOMZO5D0TeJ8BDCZ73Txq_OvxcNN8KAASOgyzAU3EYtR7igAsw@mail.gmail.com>
In-Reply-To: <CAOMZO5D0TeJ8BDCZ73Txq_OvxcNN8KAASOgyzAU3EYtR7igAsw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 18 Mar 2024 10:50:30 -0300
Message-ID: <CAOMZO5CJ1o+gznfE8C_HaNgrVV9grK-nbJfEEYuwSWPHJQPUFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Reduce add_map() complexity
To: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc: Marc Zyngier <maz@kernel.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

On Mon, Mar 18, 2024 at 10:31=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:

> I tried dumping the page table entries, but could not notice anything
> that looked suspicious.

This looks suspicious:

With 41e2787f5ec4 reverted:

Checking if pte fits for virt=3D1c000000 size=3D64000000 blocksize=3D400000=
00
Checking if pte fits for virt=3D1c000000 size=3D64000000 blocksize=3D200000
Checking if pte fits for virt=3D1c200000 size=3D63e00000 blocksize=3D400000=
00
Checking if pte fits for virt=3D1c200000 size=3D63e00000 blocksize=3D200000
Checking if pte fits for virt=3D1c400000 size=3D63c00000 blocksize=3D400000=
00
....

In U-Boot master:

Checking if pte fits for virt=3D1c000000 size=3D64000000 blocksize=3D400000=
00
Checking if pte fits for virt=3D1c000000 size=3D24000000 blocksize=3D200000
Checking if pte fits for virt=3D1c200000 size=3D23e00000 blocksize=3D200000
Checking if pte fits for virt=3D1c400000 size=3D23c00000 blocksize=3D200000

The second entry has size=3D24000000 instead of size=3D64000000.
