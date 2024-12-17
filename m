Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52BBE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 717CF801CE;
	Tue, 17 Dec 2024 14:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lv3qoKWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C1ED801FB; Tue, 17 Dec 2024 14:46:56 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2B180107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-30033e07ef3so59319371fa.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734443214; x=1735048014; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBKQ9f/jp2qxfEBqWp0kGPBSA6b+ovGeamfiK+5AZko=;
 b=lv3qoKWiPH92u4x9A7t7x0rgA92IbuvZuBGbbmOcCp8HHwnlpWXrOBjMQQSebfoiHD
 Bg8PHrSS/cgvD/z3RSo8C3jetg06hgnJqjlo2nWNMoZvXENQiCqBxWfK9iq/I685zgzE
 gmXPjW7tksfsihqIO9BokcwTbMBWXkXj1TxmsNrLbc75Dt1DXko+n12iVV31liw1kwR3
 6OmejFf29KiBd1qgCpYMs+b0YFnby8yqBUnGO4kwgIs3kj0oPhIeDpljtzujkemGvbAb
 aK3LVd6nuw/KWVmqjc+xJKIvuMjWl1951DalFkZQ3PfiIj1mWk+fQyrXg1Q4MDrMRK4x
 Ys5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734443214; x=1735048014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBKQ9f/jp2qxfEBqWp0kGPBSA6b+ovGeamfiK+5AZko=;
 b=q6gfGmYNRQvIuIRPWL5XR5uWIUjlo3299Z8e/qVJ/zBLJMt26AVE4HvYBtCcBBczlD
 YB/kV6P/V45C5LKw0wxQITJNzcLZ5jjJAl0LrhwCFCH7e1RQC7Ja1vkZiJmgWqD2shvc
 M1Zd71mQUa4AxJOc2pyghx6vbZ4iFe3ZdFpq9IdKftKhEjtMXA4URAJqFioG8EnHXiXs
 HN572z2ERItTNN6xVzPbzHnlL5piqy2hilC15XFA1rXfCRqup9ehsqgi3fuzue2GvQRL
 EKGqKm0ceGQkTACM3GZNhz0YW0HWAVyFmraJfy4PlUwRqC95lbkGlhvzc3o5vrD0tVjL
 0bPw==
X-Gm-Message-State: AOJu0YwAGVBVTAH1mEzeb15UuR81BtjpZYf85m8mhUH8Mmc3HHlMd2YR
 P83NT8p8asuME9s1AXoqYPTxwTJweZo9XG6NMa9Q2vG5Q1qbdedMvfmeHAtlGCCxhN5GHZQvj1i
 tIWNEfW3bbVChXRXp1rAVt35wIAw=
X-Gm-Gg: ASbGncslP9uR89tSuzqYjuLzTS0OarsgDXP2+2dZitgdBvWDSFnmW0O9h+j4mRuR7gD
 17wKf41z6kR5iJJAxSoRyhtUajIbieiUZ5j3HKnCg6RTWZ5xbuU8rYbB85FJTuC0LlTVN
X-Google-Smtp-Source: AGHT+IFqLzyZVpxtHU7yxcoKRkwNDRzjqzFdTaK9f02SpgAAB5ecFKJciqBYni+iys0CgQVfJo8BGClP7DowIhXFyB0=
X-Received: by 2002:a05:651c:54f:b0:302:49f7:1d72 with SMTP id
 38308e7fff4ca-30444304da9mr10378321fa.9.1734443213492; Tue, 17 Dec 2024
 05:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20241217134417.4064239-1-sjg@chromium.org>
In-Reply-To: <20241217134417.4064239-1-sjg@chromium.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Dec 2024 10:46:41 -0300
Message-ID: <CAOMZO5CJGuSLog9Gsnw0cJ55FLJ+jGE+UB3kVw=79TGQZAhUCg@mail.gmail.com>
Subject: Re: [PATCH] gitlab: Add a Colibri iMX8 board to the sjg lab
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Francesco Dolcini <francesco@dolcini.it>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Tue, Dec 17, 2024 at 10:44=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> I have one of these boards loaded with Linux 6.6.2 and a video demo. Add
> an entry for it so that it can be used for testing.
>
> Unfortunately quite a lot of work-arounds are needed to make this board
> work, but I am working with the supplier on this.

Just curious: what workarounds are you talking about?
