Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DE6C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DFA28795F;
	Tue, 26 Dec 2023 10:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fS4GvmHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E190487907; Tue, 26 Dec 2023 10:50:30 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C67058794F
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5cd5cdba609so3221306a12.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584224; x=1704189024; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWzWM7x34KsLF09llyOlWnDT/IEfRpNGVSTOmi66Z5A=;
 b=fS4GvmHf21vJwGwgYwoSnrR05NywlxB934eXnlfh8/IndsidZIeIkYhQf76fp8QF93
 qxKEK9UA8H3OnZ4TRudg5rIEE2JAgbp61wLZs27i3TFsSMryZ8tXTmJoJq+Wbszii8LM
 oO64kzXW8WQp8pEj2rzAEPsqtnWuQYZnvVuc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584224; x=1704189024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWzWM7x34KsLF09llyOlWnDT/IEfRpNGVSTOmi66Z5A=;
 b=pIQ0JlPsHGZsw8+l8hHu4rUt+YNcyNKtxmG0QVIXYSAJ55qQuIQv0jlhxvmaExMdq9
 MN8XE35G0tnNkWZUkuCh5Ar7WrCjNIHK+UJfRIb5GG8y5S6vahA+Hzi6XMT34I+V39Ui
 9CYvXRBEoFGa/uDuJ+bamLkKCRZoghjwcTpqpA9kM/c1hOM8Mvbl6MRBSqBA8oqRuQJK
 0E47qGcxUVBNX9QevUfJ4Wqd6GtFWcTCw1R+bpcgSVOXftgOvfWCJvwMVg/P6B79a+MN
 EgVEGHdSHp94Sl1ay7LAf5Gutter6DCdI8rSFeWQzXOWtpnsPvGqGVg5GI7GYaa6RKlF
 S3wg==
X-Gm-Message-State: AOJu0Yxq5W/GkBd9veLnwtpy0FSTzRrjj67V5ln2IEQJiEGaJLST2y2Z
 yYogeeuhQ+SmemOnNuZWmovDqrOlckWZfwzeTqx2/N8IrsTr
X-Google-Smtp-Source: AGHT+IGx08RL0QeUQ+I0H/7WsgY8nd0Y637EM4eQ5AQLHQueWVH03MC7BxCSPtdWBdV1atZbL57zKa4srLe+FPNzEkc=
X-Received: by 2002:a05:6a20:325b:b0:191:520b:6d91 with SMTP id
 hm27-20020a056a20325b00b00191520b6d91mr7940381pzc.40.1703584224675; Tue, 26
 Dec 2023 01:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-2-maxim.uvarov@linaro.org>
In-Reply-To: <20231225153929.8284-2-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:50:11 +0000
Message-ID: <CAFLszTiAGK-HRfPrEQ6wTU5zpx_wH7EaSOg6BZCtnR5m6NSjLA@mail.gmail.com>
Subject: Re: [PATHv2 1/9] test_net: print out net list
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com, 
 trini@konsulko.com
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

On Mon, Dec 25, 2023 at 3:41=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:
>
> Printing net list is useful in CI log files.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  test/py/tests/test_net.py | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
