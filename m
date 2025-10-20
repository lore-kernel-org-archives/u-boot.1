Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53540CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C205E82E34;
	Mon, 20 Oct 2025 15:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cRXFcwBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3905A83631; Mon, 20 Oct 2025 15:41:15 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB1C82C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 15:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c2766675adso2666759a34.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760967672; x=1761572472; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79O0qZzZpxI+J9/ElwwqUPXyjP59Ey/0GcK4t6hw7H0=;
 b=cRXFcwBgXG0lbIbCd2vtHxEnr1wXCU3phaR6dQVlGRI8KxCLzlNAhMTVVY6+zmzcmn
 RHgO3yIoIdWjnIb/6vfO3PCPxJJ+exkSWNrI0xGOGPslCcqHTTGm8RM6hWe0LnogTbkA
 k2Fo+qXLebHal8XrqZzO9oskgFUucbuA0nzZkNbojr8rLV46vQkrBtMA8Rs8dTLk3fr6
 vPRB4d3zL7qpQQkohUKDb0OTF09C80v7LQXv1J8vx9toFUPiCIHdrH5ckG1te/S1h4Mq
 jMSlcTKSO1csgevaBYn6nxF5W8Mei3yguaEPuHlkiLGhtorF3L6OAKDeU0bGRUY7fJZ/
 6gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760967672; x=1761572472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79O0qZzZpxI+J9/ElwwqUPXyjP59Ey/0GcK4t6hw7H0=;
 b=O+SmxnWKsjHsv7lSDyF5a8fNa5l8xjtAVmivgHWqY3eDp1c3QbqLRb7i2QEgKj29/o
 V3dKbUtxHW+COuu46/MLrVzOiPYpND99K1PPQBM8DIAe7+CGKt2pJM5+ffrgAdWwpDsC
 7omBODfkMrISwgMQPk956uLvXnI8f/hTDV4foW5Lk7bGgTrCTOVP4DZySMZ19pEjSJYF
 kr2rycCC1FSMYI0ayXU2mLtD7dkbp60z60HfAhMnJ7ZHO/spCLunctmXMz1vQ8SZGaVk
 Q2WIIvKLuFNFK+oiA89yztE3PmuhqkOn2xLLw/MVoIdBZIgsypMgJ+3NDZ7YJepFa945
 a1rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR3dHxCcU0J8C8Cr2MXvuQc4PIdc8hLS2oiUUBewhORcY+A0J+kPxQ6hQr8nF5OHJn/6iqg+M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0qqeVLAoYZ7DJmIAKjxo97uzF60ZJWQ64Fr9pPIFPOW3JUCX3
 q0oZWOUTj8mkkfb7+o48MfzsehgejALa6TiShf1rrTFBpxbF0MDJw19pkDpod5Doj2Mz+y7Y3JO
 5SRQPW6u4yzv7Cfzu/hme+Q196krZko4=
X-Gm-Gg: ASbGncuv0f+5OWWvaqPYGSz0cHfLyixPnbrUQ3m1Xqx7u3kkihBSpWF7G0anGt6jjFP
 jhl1ME8OEvxtdCtdz8NKIV26yoY8RniP7pAwou7PZG7LIeEQDQMLZ5Cf5/i2e6d8EjOgED41YDA
 rj9qag1VWSrQ+1mJb/CT+oPewThSIu/ZaI5kBTk2R5h5rJA2exDnghossYr1lJGI/6NgIFsPDjL
 8Efgfynab39fIf7Bns9qCGFFMuHgYJAVHiaWyH4JkYDt7smUsSDR1Z2MM+UZpoXZeplZRE=
X-Google-Smtp-Source: AGHT+IEuLmjq8uU7cEnE1LgMvtY55kncBPVWGwryqkdMKsISiR9EMs5GglENw7AMk7rr68MdR8QuLFIVV9zJHNU55so=
X-Received: by 2002:a05:6830:6f8a:b0:771:5ae2:fcde with SMTP id
 46e09a7af769-7c27ca3115amr6030063a34.2.1760967671732; Mon, 20 Oct 2025
 06:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251020133100.1837-1-briansune@gmail.com>
 <CAOMZO5A12FSgx3XoxZQBmtdqLxxZ9CbEDz4p6Ar6gcRqH6Uhhg@mail.gmail.com>
In-Reply-To: <CAOMZO5A12FSgx3XoxZQBmtdqLxxZ9CbEDz4p6Ar6gcRqH6Uhhg@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 20 Oct 2025 21:41:01 +0800
X-Gm-Features: AS18NWAbTJ_X8JhuF9D9ul7z1_IR9OIrxQnoJsyF59vXHvExzmq76EVdVR2uDIY
Message-ID: <CAN7C2SC=pwvOFA3JpRhufkTqfUsJL2mNUKdLMdtZ0-rXYQjQ4A@mail.gmail.com>
Subject: Re: [PATCH v3] Altera SoCFpga Boot Stall Fix
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Fabio Estevam <festevam@gmail.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:33=E5=AF=AB=E9=81=93=EF=BC=9A

> From and Signed-off-by lines should match.
>
> ./scrpts/checkpatch.pl catches this mismatch.

Sorry about the repeated submission.
Just close those that are violated the patch format please.

Brian
