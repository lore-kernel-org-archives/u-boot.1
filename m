Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61EEE9410D
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 03:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2366683FF5;
	Wed, 31 Dec 2025 04:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="l9bBtPP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B77983FC6; Wed, 31 Dec 2025 04:21:05 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C2A683FC6
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 04:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso14034977b3a.0
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 19:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1767151258; x=1767756058; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1sAaOmUyK+vAoEw0/ONGjzJSti3Ds8OGeGB3mJH6uk=;
 b=l9bBtPP2ko8ijK5mFE7q4Qa15ugQHLSSLpRVFp45k2omnHioxibbGVArdwq345eSJS
 kG+j2kkwwHg8oN/GEwBI/kQg77aTmazuh40xu23JmLPsJSe0KFJgvzexYkn8D5moq1sx
 26Kkwq6KoeHgiUGeEukM9Ws2gbEu14BDdR+RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767151258; x=1767756058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1sAaOmUyK+vAoEw0/ONGjzJSti3Ds8OGeGB3mJH6uk=;
 b=LhlsMzR63sYosv8bY+77IHXbMxwxJOjzcZmcRCLbpo8L3R7vFn/bGldbfDQ+ytRq6k
 JAvOh52dCWp2eQt8B2hEs8GBPfZzmvaMHZkLH8J6raEUKRLLcBobBXHmx7YUJhey1Bzl
 e0Egja51CQgPu01GmfWfJeTFNyKVM8YEQv5v1yMQOHv8bKjNJAvrZ0DhESVkd/+VURD0
 /MZ3ZcxkJ9YfYanGaBMwLpfMEbG/WQ9WTyXZ8TuuJXGMDnZvZ60BEPqCaJAUMyVdd1RQ
 rdE+lf0Ixw9Gbp+ffDt0FIpZPVOOgkCEV1V4WSPfbT52yDr0sV/qopsbt0GPualAuO+k
 1qow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKgAk88ntP5dcFDHhID4CrbMlwcH7XPILZgEasTFQlg4ETHoVeJuDYvilTBt48m4Lc1JHGU2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwxkpREdnNGdNoFb9itaJ+kLG2JsgQz9dtYT6nlOIsKOWtzWcf3
 khNLAnO6CA6ZkapD0XHQJ+WrnmkJ599I+yWESllH9VSL3WFcQMkSvPo8r3P8SzrVfALUIMVrzGf
 oWF/iLxAIbYFZ/gZ+0YK842OREKDgQSkd+ml9/scphA==
X-Gm-Gg: AY/fxX6GABzSb45j+CaPuIwQRbdWKqr9nBfsGHaTSZSKR67PJC6lyG78CRUY5B2QgZa
 TK60ctea0jUfZZ/5EBKSTb0T+o45ldjXsIJOMhALzRQ/5porRMusZDUbZBIPjBM0wDTWu5aL0ak
 he+GlKoF0bNmX4r68SfLrSKoG+zsLkZW3WswlkkOxhykjmHEo3Xt8Lt982chsiQSpjjElxLokoE
 f5b4uuWIq4n7lut2s9kemwaYyJMkBNCpIPjwi1MbMaL7M+05pzprBTBGuy+7IjmF2vFQAEl1LXa
 1GUqDtM=
X-Google-Smtp-Source: AGHT+IE9r5evp258SYrUsO1jcaHa4V9DZGNe9d0qZgvfNsKwnln2J7vJQcSYuQYF+aLhEKabcc99aWNS065bf4JRZ04=
X-Received: by 2002:a05:6a20:9150:b0:366:14b0:1a41 with SMTP id
 adf61e73a8af0-376ab6cfb64mr29275704637.79.1767151258418; Tue, 30 Dec 2025
 19:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-4-visitorckw@gmail.com>
 <CAFr9PXnZPOw3V9vwxtpvkVFfjOt10ZmfSjY6yMLcFnGW15bvZQ@mail.gmail.com>
 <aVGBVwgr8528wTcn@google.com>
 <CAFr9PXkk_eVwFG4SA1BCB_S+kUoJHPSdsOJZK5bXB+=_an91Mw@mail.gmail.com>
 <aVKFyqkgt_n_4qX7@google.com>
In-Reply-To: <aVKFyqkgt_n_4qX7@google.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 31 Dec 2025 12:20:47 +0900
X-Gm-Features: AQt7F2oEO9Tetq31iWCL-Uch_7X-U-Mc1ajaVjBhSReUzTMQqAgmppHxUFGta1o
Message-ID: <CAFr9PXmwb2GBqCpyd+UHrwpFeLe-YCpU-RzaYFHyiBVj78peGQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] board: Add QEMU m68k virt board support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Mon, 29 Dec 2025 at 22:44, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > Yeah I think so, if you didn't find the last bootinfo entry within
> > some reasonable bounds everything is probably broken and you shouldn't
> > continue.
> > I think for most real machines (Amiga etc) there aren't many entries
> > but for the virt machine maybe there is an entry per virtio mmio
> > device so there might actually be a lot of them there.
>
> So the problem becomes determining a reasonable limit.
>
> I think we can safely assume the bootinfo buffer won't exceed a 4KB
> page size. Since the minimum record size is 4 bytes (tag + size),
> setting the maximum records to 4096 / 4 =1024 should be a safe
> assumption?

All of the bootinfo being on a single page makes sense to me[0] and if
an error is printed if the last entry is not found within that it'll
be easy to work out that there is more and adjust the limit.
That is a lot better than the bootinfo being corrupted and parsing
random memory until we hit something that looks like the last record.
;)

Cheers,

Daniel

0 -  I feel like I saw that assumption somewhere but can't remember
where, maybe in the EMILE mac bootloader..
