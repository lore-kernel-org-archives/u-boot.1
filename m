Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3B3CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 19:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0FDE839B7;
	Wed,  8 Oct 2025 21:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XdcceYBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC25D83A2A; Wed,  8 Oct 2025 21:35:35 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E052C8394E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 21:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7bc147fd11bso148927a34.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759952132; x=1760556932; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76uk0OHI+5n3ML6ls1R7dYdw99TNmYqJlG305+HFdTk=;
 b=XdcceYBh2mto2AV832Ake/6BBruYrcbXa6ukO2mouyWF8yu8kd9qLxCVAYP4tos4Cn
 jz2MQ0mmbgrp84+VZidaeMUuF0yMtm5PED3s8nQAb/rO6tddHpupJVVKi6UbyKbx63Jm
 a9lsF3DmD5Y5v1A3wxW7MqQUWyHrXxWuHE1OKK36XDwLpF00S5BF0xKS4iiSq1K80I9D
 pXbu/ZlfUC4FUzkMcA84wH6MT/FPizYVGD1HdmH6CJRzvimchT+vaKiQyNshm+Zzc3SD
 LfGjIMGe+5p4ADSw2EH0nPb5UQMQR3fUXrsXK/DzMxZqCasxXTYYsMTZvZvQ9UhpEHIN
 E7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759952132; x=1760556932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76uk0OHI+5n3ML6ls1R7dYdw99TNmYqJlG305+HFdTk=;
 b=IOw6cvzL3AxWqBKe0tXoIUMRGtEDi2sCf5suvuctCAqx6GzKK7dh9KiwWzetSycuRZ
 JLn5/iG1VpMxC2lbworbP1BydBr4qdxzM2012FdqSXkVfm4Na08NGWObHPXbUw2ZVUd+
 6hO4PhsCJKyHwkmI+k44s5gduHrKQ98mFiV4U4dyQbNxnCvkeRK8+LWfVUyrYyhk5XEP
 5jWcEjfmvMvGYRAl+Pse6iqOgyg87f+b81s5Zk5aR0CS/twi46R1w/LHbanHJAafbHwb
 tZm+yG4hn2X/9jAFUoJOduDaeYykk2YvO9pAOzbag792hdepke0xjlG9lJ8IATwG9/tG
 1KFg==
X-Gm-Message-State: AOJu0YxM3c6x6Q9CFJX8cwzCS6xp6zw79rQ7HbT95dEBcY/f/84Knfq6
 ryht9ycYbeQ9rE8d6EtUVlrS0q286rPRjok55z3cOOCtFE3vnPzBsQTRkBLHZ8Vhte00EHYFcX6
 HTxmKLmusO8kysLXl1oW2lKGeJ07IdBmWp7+uFzOHbA==
X-Gm-Gg: ASbGncs02cBAZBH6BOfaTDCp1LeMej+NV3S6s99jKV5uRLv+gHZ7HPOzMOLZ6rX3iov
 9LetRHomchtegcOTLPfLlrn0FocPwVth4UdO9Ktwd7UAvoe5f/F5quaPEEnJnHvDxWWNv9QPCYp
 i2Jqv6847+6ZmmZDN55Z38jarJfljZ2fG8uqa4brZVyIBKBZQqOZZaGay7scW5D8nVLOR/ZOHdj
 fNtTkbWl8q7S+/RTvzJhOXUFARYjns=
X-Google-Smtp-Source: AGHT+IET6ALlYlo2R+XEAfDKd/yMA0KyOyQpC+M9P2V4xYDfRh22AMgh2UEK2/xgxi9qUyUJ2YiWqAz0HLRhXYJQlmw=
X-Received: by 2002:a05:6830:3901:b0:7a0:239:8098 with SMTP id
 46e09a7af769-7c0df6e3f2amr3073993a34.8.1759952132609; Wed, 08 Oct 2025
 12:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251008174408.381-1-briansune@gmail.com>
 <20251008190713.GH298503@bill-the-cat>
 <CAN7C2SAaia8qV4sx-uMF2Y1GE4GW=WmmgSMHMApW0YoTzTqQOQ@mail.gmail.com>
 <20251008193306.GI298503@bill-the-cat>
In-Reply-To: <20251008193306.GI298503@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 03:35:21 +0800
X-Gm-Features: AS18NWBoTQDEsINLhMgHHmSDta-lV3aq-jWcGtSHq2pppobSEMoUKO1tPR9KmQg
Message-ID: <CAN7C2SDaP65Eu914rAzNdhKG9oAUEeM9EhE-EEh2odONnBjWVw@mail.gmail.com>
Subject: Re: [PATCH v1] cmd/dma: documentation
To: Tom Rini <trini@konsulko.com>
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:33=E5=AF=AB=E9=81=93=EF=BC=9A

> > > This needs to be included in doc/usage/index.rst (alphabetically sort=
ed
> > > still) in the shell commands section. Also please do "make htmldocs
> > > KDOC_WERROR=3D1" and make sure there's no complains for v2, I see som=
e
> > > style issues it will trigger. To build the docs a python venv is

There is an issue I am not sure it is ok.
My system is old python 3.10 is not allowed.
Could I downgrade pip library version to make the require documents?
