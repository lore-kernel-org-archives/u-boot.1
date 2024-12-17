Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9597CE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 10:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34B83801F9;
	Tue, 17 Dec 2024 11:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GOshBm5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C26E8021A; Tue, 17 Dec 2024 11:57:14 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81784801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5401ab97206so5365580e87.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 02:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734433032; x=1735037832; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhKi6OFI1NNWxsg7Sq5+LBgYbYcU91yFi5bTbppTf08=;
 b=GOshBm5gLhIYNEX8s+9f9sYHgS/ebqIrCVqNAlZ5aBmfk5jxhwN+oYuMAGwlzfUdhM
 hQv+GpX9ufC4srpKrLwwaNUzkwrmiz7b0Xlxj+1Y7dP6bm+/jJ8T5ZFOTyEJIuz4pPqe
 mdYgvQdEcvatp3vJlEt5RJ5/qlsCkViKgSaMgiZVcalP3ct/vey4GuczZZNlwXPGcro0
 VkAnqUAcq6I/XQBUBAFvB0tnhxtK7aVq89PQWUo+S4qIhwE3cOzbqQttfn1oyCH2G055
 g1Z4Etk46000O+Zs5Vp2uOHNcPqj6rPk5ukMOpvpdE26CXWOIpNns+yfXcrbyAOtMD/9
 mGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734433032; x=1735037832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhKi6OFI1NNWxsg7Sq5+LBgYbYcU91yFi5bTbppTf08=;
 b=SG6/LPqiDKpbOkt5AQv4iDUHU56FwVOKqUvV5qpiHzkQ3NeqiwWBHkRUm8/XAV5hh0
 P7/EQqZ6o/3PwjlNt9XhqOUei14200UV16VPMC9d5NEycPUIBgrXfaEWYX0V2f9Qk6GZ
 jwd5LJ7Vbsd03M0mcY7D7F8F5XqDZpIjwKCRGcVJh75fIGYCv/n8f/soEjeLVVVkMww7
 DOBRPTvgnYogfn6rXH1fYbZ1COTO8cbS9Hwt6knEosaebiFoATCfO9eyUev8HRE2TvVy
 C97iYZ6s7xXl+QeLBrkC4LqDTEge5AtZHsqG3l8cqs3yhkBJLdUwi4WeI1Nvu4g2Cfzt
 xE1g==
X-Gm-Message-State: AOJu0Yyyndeufh6Ie6OTIBi0K7xiyGQERDgKY4IddaWWtBdybTWkfYIA
 tm88k+Pq6uSONfBQGwH6X+HXlnNaVXphyg6FiQJRp4vFNbRWf41Hw50C6Vaj/NLO0qwaJ9TBoqT
 Q3Lv61A8YKIcOTLUL5tnQVWs5vnw=
X-Gm-Gg: ASbGncv2w4YgBFVfDDJA6nPXejeZJI7toBFdTja4eXnJQUEahu46vAcBgh+IxkriEuA
 uhIN7VJ1rcX+ae0r2RCaFDBxQKiOAtg+3cNzThbggStipEowLnvAv/O8Zsin1SvGBzond
X-Google-Smtp-Source: AGHT+IE7RBHrdaTHJE5lfn/xKpGeMzRCoOcSFbMyeGgUN7TWCVLMk6bt+3lKC2tzHWIIonimpCk7QFXJd8rnIZMpgd4=
X-Received: by 2002:a05:6512:3c9d:b0:540:3561:8854 with SMTP id
 2adb3069b0e04-5409054d67emr4874568e87.17.1734433031540; Tue, 17 Dec 2024
 02:57:11 -0800 (PST)
MIME-Version: 1.0
References: <33e7b95383c1e5dd20f4cd2e30b88391a09e0858.camel@googlemail.com>
 <CAOMZO5BezDHXphjvX+Kat6rFq5zYC5yVucET2NzTHdFYnYTqXA@mail.gmail.com>
 <01420bb81265f69bbcd56dbe658fc0528d94e87f.camel@googlemail.com>
 <CAOMZO5CZ2cnAozFUnybUYWQUQ4CyvuDWWy6pbVq8SnbBe_RXdQ@mail.gmail.com>
 <51e0a4c717b0fd8bcb9945483878c5c914d43892.camel@googlemail.com>
In-Reply-To: <51e0a4c717b0fd8bcb9945483878c5c914d43892.camel@googlemail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Dec 2024 07:57:00 -0300
Message-ID: <CAOMZO5CZ47LiMiYjAYNzcEkNpkutxUWse_UV2mdsV0n-0mO5Zw@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: fix srktool -c usage by removing spaces
To: chf.fritz@googlemail.com
Cc: u-boot <u-boot@lists.denx.de>
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

On Mon, Dec 16, 2024 at 11:59=E2=80=AFAM Christoph Fritz
<chf.fritz@googlemail.com> wrote:
>
> The srktool option -c does not allow spaces between certificate
> filenames. Only commas (',') should separate the filenames. If spaces
> are incorrectly included, srktool will not display an error or warning
> message but will only process the first certificate in the list.
>
> So adapt documentation accordingly.
>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>

Applied to u-boot-imx/next, thanks.
