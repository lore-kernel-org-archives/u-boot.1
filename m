Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF84C47DDF
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CA587626;
	Thu, 25 Jan 2024 15:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HfqOR48d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70243876FA; Thu, 25 Jan 2024 15:34:46 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8310B80090
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2cf0390eddbso51908801fa.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706193284; x=1706798084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hMNrKY4rMpNiLEIiRJSq2xNQmJTN32KO8AuL1EjJXBI=;
 b=HfqOR48dS7p2GDEL9HT7+8VKJob+Oz5BpWCiUAbDxFLEQYYIbZMsb+Q8fB3HD6/o4S
 Jd6C//nvQbXhyZhzYvKa+ZKsDnF40dPcGf249YtKud8mNxK6W0KL1xRLEnM0l5+bnaup
 NT/ZyDaeUcjWZ2v8aiUXsegV5YBYYNanCglXxF40DPoJPWUPSotX0ISPMLV3fmXrIw3u
 w3sYQKJgqw1MduaVzBpLZuyufytISCBdk9C6a52Qr7naZSelzlmqZg+CMfQS2484P/lx
 4TMXs3A5tLQZPJpMNINjNMMqcvHwy9Xc7gh8olvCf3YKw4nSBqiAmYDTxE6BY8UEGNi0
 7VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706193284; x=1706798084;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hMNrKY4rMpNiLEIiRJSq2xNQmJTN32KO8AuL1EjJXBI=;
 b=KEZTFnKcvVKb4TGHFmPm+MY99iwqJ8OjcAVU1/+talA5VZgl0KVfpTlZB1vP0FXpYN
 gMinjjcltPJT1n8ogTTmB13zznKUIhw3oH9s+k5c/ctc2W9jPq7gCHg2jFdxbrUH9fBi
 6PAXOULj0+kNN1yxYtsmDJdwKjlm4EG1/2TZemHE+reHImkUfhfNuX5wTuxQw2mMlNhU
 3JxkshIKT28MMDjq7LiHriv4q/Qc55sPb6qZz/FmhTM5wvLerclhrDRZCM1ylTVAnLbO
 /U/N2mnHKUK8RF85zhEZWRHHIuNZym9WVGIqXeeIgBKcPB2buQbd65zGIf6XJgKctZif
 ZiDg==
X-Gm-Message-State: AOJu0YwqY7L5mGVsu9txQ5cPdgLmhOdOuvSg0i/ajMh4d+6J0rWZdNRb
 a8Ggo+rYZxpG2vdQzjSR98pahW0DNzIMBb5k8WyGrXZDn0UqdMrY
X-Google-Smtp-Source: AGHT+IGbCoqQ0x6psp88zREvsywu655ru5cRDHqPhrEGLAJfdW8VPWQSwiOrLcZ/IQxpIFlJmrmqJA==
X-Received: by 2002:a2e:6a16:0:b0:2cc:65dd:3320 with SMTP id
 f22-20020a2e6a16000000b002cc65dd3320mr628285ljc.27.1706193283605; 
 Thu, 25 Jan 2024 06:34:43 -0800 (PST)
Received: from [127.0.0.1] ([46.211.247.89]) by smtp.gmail.com with ESMTPSA id
 k8-20020a056402048800b0055d0a05b1bbsm441457edv.5.2024.01.25.06.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 06:34:43 -0800 (PST)
Date: Thu, 25 Jan 2024 16:34:41 +0200
From: Svyatoslav <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 =?ISO-8859-1?Q?Jonas_Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] Fix booting kernels with ATAGS and extlinux
User-Agent: K-9 Mail for Android
In-Reply-To: <20240125141734.GK3652023@bill-the-cat>
References: <20240124202731.39212-1-clamor95@gmail.com>
 <4b77da9a-9700-43de-a833-14f809e2919b@moroto.mountain>
 <FDCB4AEF-9106-421F-BB9F-16E2339B2148@gmail.com>
 <20240125141236.GI3652023@bill-the-cat>
 <389188F7-7622-4109-87B5-7B136BAEABB9@gmail.com>
 <20240125141734.GK3652023@bill-the-cat>
Message-ID: <F6B6FBCE-59E3-4334-8E24-4BF5C3C4D9B7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 16:17:34 GMT+02:0=
0, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>On Thu, Jan 25, 2024 at 04:16:11PM +0200, Svyatoslav wrote:
>>=20
>>=20
>> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 16:12:36 GMT+0=
2:00, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
>> >On Thu, Jan 25, 2024 at 08:51:09AM +0200, Svyatoslav wrote:
>> >>=20
>> >>=20
>> >> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 08:29:54 GM=
T+02:00, Dan Carpenter <dan=2Ecarpenter@linaro=2Eorg> =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>> >> >On Wed, Jan 24, 2024 at 10:27:30PM +0200, Svyatoslav Ryhel wrote:
>> >> >> Currently, if boot with extlinux=2Econf and do not set the fdt
>> >> >> U-Boot will provide its own device tree=2E This behavior is
>> >> >> beneficial if the U-Boot device tree is in sync with Linux,
>> >> >> but it totally halts the booting of pre-dtb kernels (3=2E4 for
>> >> >> example) since it uses ATAGs=2E To fix this, pass `-` in the
>> >> >> fdt extlinux field as a signal that no tree should be used=2E
>> >> >
>> >> >Passing - doesn't seem like the most intuitive thing=2E=2E=2E  Is t=
here a
>> >> >different argument we could use?
>> >> >
>> >>=20
>> >> I agree that `-` is not the most intuitive argument,
>> >> but this is a way to implement a fix with the least
>> >> code posssible=2E To make this less obscure I have
>> >> adjusted documentation=2E=20
>> >
>> >It's also how historically we do similar things=2E eg, "bootm
>> >$kernel_addr_r - $fdt_addr_r"=2E My question is can we re-work this,
>> >cleanly, with guards around SUPPORT_PASSING_ATAGS to not increase size
>> >anywhere that doesn't need this legacy case=2E
>> >
>>=20
>> Which behavior you propose?
>
>Well, using the IS_ENABLED macro with the new tests around "-"=2E
>

So using "-" for booting with extlinux with ATAGs is fine for you? Guards,=
 sure, I will handle this=2E Which tests you are interested in? Maybe you c=
an point to an example? Thanks=2E
