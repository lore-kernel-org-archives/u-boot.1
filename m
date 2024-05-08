Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6E3C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E1F887DF;
	Wed,  8 May 2024 16:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="USnpiLZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFF4887E4; Wed,  8 May 2024 16:49:31 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 214F1884E5
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5f80aa2d4a3so3327046a12.0
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715179767; x=1715784567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nIZugMVpAuMplICMq9nsvZTBgsJITE2u/u4JRdQT5W0=;
 b=USnpiLZmCw1/AcsIe2ChRm7yhzr2O5qcvwKr6QQ42WktnzbuW6FNOE8upj50go4tIh
 TQH9bedrZzXRxek+m6czjSFhAhLX1sfhHfoTkCKgc2r4e6ZSKl3AXmeTaPwh82v3DZQd
 TYjLmVL+57RnF9Rb0GLhB/l2LgH0mUw21zjxPMWNu/2594bCcJGCVvkIpJ/MFBULhbSv
 69YHbNBR8uNO1PeJcA/tsX9rhnpnDePwtAYt0eZWA4W63PJJJL4q28iERcT6N2Sz6Sgf
 iNnPmzOm/BRIh4uM3VcTQZsfkVxm9ZKXRsrxm3gWhgsrd+fi0gRP2/unwi0yk2vel5Af
 KT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715179767; x=1715784567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nIZugMVpAuMplICMq9nsvZTBgsJITE2u/u4JRdQT5W0=;
 b=bPNfLg2FCIUohzB14Q4vpPWJK8y+87ua7PUHSJFXibF+p0YgYWGFp2BaCQ/2R5ZJIn
 rVPP/T5DEXeyTk7BvnqPRvDKIpP9XmoaTVrXbA1XSbHO+mvzwDwYpSPOBH1WJa5l3xYa
 XTOvs7/zMK4zp+rBxRz4Dp8XOK2Vguq1zWdatHRP+Bf7Nor/hEYfdPr7Z1o5KWNlHvce
 6jWewUdAtj/Yqweucn0Zk6i/0AQFud+LB35xICq9hHjKgO0BnAZ8i7ciOqVrvGV7PQGE
 rXulWGsFtISfGD8Ym/5Qftwt6V9PF99reSHckCdMJtkcdTWXWC03fVJ0FYdnkCjQ86u2
 q+Tw==
X-Gm-Message-State: AOJu0YyEeEiSKEAA7qisc6Tav+JQfxU4KTLs3lw7YECMyWmqoc9udZLm
 jDuUpvoiRf5baucPfqampwdfTm0LoPfUlA1vAaK8Xe4ZgUDhmBlTCNec5K86QSGodyiNmMFGaLL
 AcjmNCvmYEfVo6wdu5KDe3WJ6M6d/FbDhDqpIWw==
X-Google-Smtp-Source: AGHT+IEV0icQ0weVwcNRfzXu2Hzf+Buj0RzlN2rvGcZBKelXFXWVNfIOqozAFzTchq+TabKgNUYbZW7EdM3Kpr1QvZI=
X-Received: by 2002:a05:6a20:a113:b0:1af:9ec6:afb8 with SMTP id
 adf61e73a8af0-1afc8d3d498mr3069561637.23.1715179767613; Wed, 08 May 2024
 07:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-13-raymond.mao@linaro.org>
 <CAC_iWjLd2L+gnGMTCbFZSr9hP5UMWvZir_QKHCgg=Le+pRu5Hg@mail.gmail.com>
In-Reply-To: <CAC_iWjLd2L+gnGMTCbFZSr9hP5UMWvZir_QKHCgg=Le+pRu5Hg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 8 May 2024 10:49:15 -0400
Message-ID: <CAEfUkUJr=8F-4r-AaNbisDQADy2JiKLPbPyYK8GrKjCx85=HMg@mail.gmail.com>
Subject: Re: [PATCH v2 12/28] mbedtls/external: support MicroSoft
 Authentication Code
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Bin Meng <bmeng@tinylab.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

Hi Ilias,

On Wed, 8 May 2024 at 10:32, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> On Tue, 7 May 2024 at 20:57, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Populate MicroSoft Authentication Code from the content data
> > into PKCS7 decoding context if it exists in a PKCS7 message.
> > Add OIDs for describing objects using for MicroSoft Authentication
> > Code.
> >
>
> We will need more accurate commit messages for things like this.
> IIRC this is already on a PR for mbedTLS and won't be needed in the
> future right?
> Generally speaking, we shouldn't carry out of tree patches unless we
> can prove there's a very good reason. This one needs to be marked as
> 'do not merge' and we should wait until mbedTLS merges it upstream
>
> I can add a tag here to link to the MbedTLS upstream PR for reference.
However I think we still need to merge these patches, since MbedTLS will
not merge
it in v3.6.0. Without it, the EFI Secure Boot and Capsule functions will be
broken.

In the future, when MbedTLS merges them in later v3.6.x, we can simply
update the
git subtree.

Regards,
Raymond
