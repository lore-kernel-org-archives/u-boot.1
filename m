Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10B5C07CA9
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 21:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AC287561;
	Tue, 28 Nov 2023 22:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q8wnTd01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813D687776; Tue, 28 Nov 2023 22:14:50 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8051987561
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 22:14:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54b450bd014so3913847a12.3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701206088; x=1701810888; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EJ9qP9A0aVWkH3dg4vUZYKhvzmIva8Mpiep0v9bQvvM=;
 b=Q8wnTd01TQawo5HuPgC9kgO6qIDgDvMoza7AUAqcHzg8d4KYFb/+kjtk5ZxHX2/i0b
 7X1WfC0AWPbxa+r641aiLbDsMddfUVdOquheWK6Hs4lGEUiXyrb/I5SeHcaWzri9DMhA
 TpHTi/Ry/loHgMdh2vhxLBv8RZdjO7ny9xXvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701206088; x=1701810888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJ9qP9A0aVWkH3dg4vUZYKhvzmIva8Mpiep0v9bQvvM=;
 b=WKBRjtOjy8aw69OoAO8h3z4QUCGVHY7TQLBmdbxoUffqa7aiSo7cY8uzcIq00G329O
 Tb9FLmJAlfLaCHbvIR2b17FpONqI2+1pwSvFutZLc3MQfK136vSJNLw2yuWlDKIZzYce
 wA3lD9oel3KdgbWjIIXCElvSU4U8T7WDunhhCMn1m8EMzt9ImtQDghMm7HfUQ8gzDHc6
 jCQC+NfHdMHzocwKryPuEoM1DHZq+4J59UMYwzvCanbb+Heo6RGj8f2+b8kRxULkSjNr
 Y+qXipShKR5sxZE5ml0R+tle+yogovqzwfb16gPIukqqIl6Oz6AdMH2vsM6OCjsMVLNZ
 SOww==
X-Gm-Message-State: AOJu0YzaKJ91AK176dJcbaPFO+/LjeYWYbNAdwFo5qWL8vcg1Z1Q2VWO
 QqURP87aRYhTm5WGjGJ1CQ3tW++JgKcw5h6aQoMjTA==
X-Google-Smtp-Source: AGHT+IFIOZIsfpM/leN9LlIpgsa2XHNB2dCfC0XBfEgME02EogNcK4oQslyy1y7c/qHXHimUB77Qzl08P7u+uI6NPbM=
X-Received: by 2002:a17:906:2287:b0:9fc:4c88:a723 with SMTP id
 p7-20020a170906228700b009fc4c88a723mr12134611eja.26.1701206087669; Tue, 28
 Nov 2023 13:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20231118210547.577026-1-sjg@chromium.org>
 <20231118210547.577026-32-sjg@chromium.org>
 <20231128182117.GA2513409@bill-the-cat>
In-Reply-To: <20231128182117.GA2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Nov 2023 15:14:30 -0600
Message-ID: <CAPnjgZ3xjAoupUJznP1Qs0vuyK+n3X2kz2VXbgBT7KLcLcxNAA@mail.gmail.com>
Subject: Re: [PATCH v3 31/32] bootstd: Introduce programmatic boot
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, Ivan Mikhaylov <fr0st61te@gmail.com>
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

Hi Tom,


On Tue, Nov 28, 2023, 12:21 Tom Rini <trini@konsulko.com> wrote:

> On Sat, Nov 18, 2023 at 02:05:19PM -0700, Simon Glass wrote:
>
> > At present bootstd requires CONFIG_CMDLINE to operate. Add a new
> > 'programmatic' boot which can be used when no command line is available.
> > For now it does almost nothing, since most bootmeths require the
> > command line.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Overall, this seems fine. The only ask I have really is, can we think
> about how to handle both this case and the case handled by
> cmd/bootmenu.c in a common fashion? To me, one is "show a menu of boot
> options, based on env variables" and one is "show a menu of boot
> options, based on C code" and the "show a menu of boot options" should
> have a lot in common.
>

I had not thought about providing a menu with prog boot.

Could we drop this patch from the series for now and apply the others? I
would like to finish and send the follow-on

Regards,
Simon

>
> --
> Tom
>
