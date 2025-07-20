Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF61C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 11:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD03D82F00;
	Sun, 20 Jul 2025 13:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZiilmbzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F09382F49; Sun, 20 Jul 2025 13:48:43 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED5B82E37
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 13:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lordrasmus@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae0de1c378fso509633466b.3
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 04:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753012121; x=1753616921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BxHb+ywZNgjm1c8x7Yrrw42/CYjbUmyvk0UeyrXf/Zw=;
 b=ZiilmbzMheJD7lhTXeKZ87fZpWd5Ind4NmxPWNF5TanJVBOzvlsfjK74L77VLQfvOl
 3N58nukN9Tw3qIhHmw9qgYNBF/taw68lzsvPDdciQty+Cw2VzHYE3klKPRjltGLCQvF7
 IYf5pAcKR0BBebwg/SC7JXr/gZ1QawueyeMoXrTSfLtmbWo1DrjRexTiQh8BGljFz9J2
 FzL4nVd9+krKnAEXB7zEsCe+t4SifiZkyzBCokT2k4RFF6Lk4Ka09PFYA304PeV9H7aJ
 vFImPFeNmgBSLmt/0qyAB5Y7Xzns1KQtkkJf4frSe3wZo5VC1B14SzuSluAf+31BwrXW
 UX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753012121; x=1753616921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BxHb+ywZNgjm1c8x7Yrrw42/CYjbUmyvk0UeyrXf/Zw=;
 b=Eq3aV2SyEkr0P75DcRsC5tripmg5MheDJ9suKUIKXXam+Uw1RoFIl8wyiJcDESm0vW
 DN1geXkXTI+lMiMedWZSkbbuUFbyz9mR+ULnXXuixPphM6gif2kdgs4nSmAn7goEXepI
 g7q86128wuU1s2AIZ5V3tgYgmZ89VcQ65nFcrrdpY8tRol3BKRFlWHXx9Pdtgcxsdydy
 8w6ULY5ddeU1qOhu19TIivL3cBmkUrvCQ1vywUHeXsTP43YE/eDJKW3Ixs5EkPQHR1K2
 Zi8p9y/UYVu/nggB9o6fJIST9JXh+lvz9aR1sDMXRaGZ8lZ3ZxRFDIj3/KTDsgDL/UuL
 M1dg==
X-Gm-Message-State: AOJu0YxqjO4YLa0Wamrde6VGxcLu/HBAAaIXWkJqebMVnqTPLLVYPGWQ
 p5XBWkGMKSUXdO8YyRW8TBd30mSKZh0vGfFwOMsER8lXStXPa5aSW7CPXVkGUNB0ZdO9T4zu08Q
 QSbvvVBmTs8NR2cHS4wAdOH8fkm6Ta6E=
X-Gm-Gg: ASbGncuV+cEdYKJhQC7RDq8NMNM8QIKPGD93JdOTYi/Ca9P7wbAjvpj3YupTDQ7lzlR
 HODrKj8st10wETRIgv8NDXgCkTypuuXOm0ksFdg9v8F7UCiaIkb4nOPlQY40xb2y+I5DzTmb5t1
 gAfOgrkBBas5G5332rC6fmak/YORH53v0/4K6fF1wQtTaNrOAFN0Oau0CBDWplW9mK1pzcWtuAH
 bZS/w==
X-Google-Smtp-Source: AGHT+IF2GP/paZ6GZiL5yfrQn3NLptdkB6RLxENxWhP+OMzMNuSH/FvgvYMY4oau75+B7Wj/EQhYLzY+Siyb99jmxVc=
X-Received: by 2002:a17:907:fd15:b0:ae3:cf41:b93b with SMTP id
 a640c23a62f3a-ae9ce10b28bmr1503019066b.41.1753012120482; Sun, 20 Jul 2025
 04:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250713160826.108821-1-lordrasmus@gmail.com>
 <0c6dc75a-1252-4236-a322-61def9b17775@linaro.org>
In-Reply-To: <0c6dc75a-1252-4236-a322-61def9b17775@linaro.org>
From: Ramin Moussavi <lordrasmus@gmail.com>
Date: Sun, 20 Jul 2025 13:48:31 +0200
X-Gm-Features: Ac12FXwSV9rQlklKTE1wUjP7Sp_yY8kuyShJEN-CaLagpd0iS3DSyGFoA9xW05s
Message-ID: <CAJxQxNDMFGc1NJBEJ-uOUp6f=1NmRBWXT2FY1rJsQocrhZsRiw@mail.gmail.com>
Subject: Re: [PATCH] arm: atmel_qspi: fix race condition in transfer
 completion check
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
Content-Type: multipart/mixed; boundary="000000000000bab8aa063a5af0a1"
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

--000000000000bab8aa063a5af0a1
Content-Type: text/plain; charset="UTF-8"

Hello Eugen

here is the updated patch

Am Mo., 14. Juli 2025 um 22:33 Uhr schrieb Eugen Hristev <
eugen.hristev@linaro.org>:

> Hello Ramin,
>
> Thank you for your patch.
>
> Can you please change the subject to have "spi: atmel_qspi: ..."
>
> On 7/13/25 19:08, Ramin Moussavi wrote:
> > In atmel_qspi_transfer(), the status register is polled with:
> >
> >   imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
> >   return readl_poll_timeout(aq->regs + QSPI_SR, sr,
> >                             (sr & imr) == imr,
> >                             ATMEL_QSPI_TIMEOUT);
> >
> > However, this is racy: QSPI_SR_INSTRE can be set before QSPI_SR_CSR,
> > and will then be cleared by the read. If that happens, the condition
> > "(sr & imr) == imr" can never be true, and the function times out.
> >
> > This race condition is avoided in at91bootstrap by accumulating the
> > status bits across reads until both bits have been observed:
> >
> >   /* Poll INSTruction End and Chip Select Rise flags. */
> >   imr = (QSPI_SR_INSTRE | QSPI_SR_CSR);
> >   sr = 0;
> >   do {
> >     udelay(1);
> >     sr |= qspi_readl(qspi, QSPI_SR) & imr;
> >   } while ((--timeout) && (sr != imr));
> >
> > Update U-Boot's atmel_qspi_transfer() to use the same pattern,
> > ensuring that both flags are observed even if they are not set
> > simultaneously.
> >
> > Signed-off-by: Ramin Seyed-Mousavi <lordrasmus@gmail.com>
> > ---
> >  drivers/spi/atmel-quadspi.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> > index 8aa7a83aef4..fba32876f8f 100644
> > --- a/drivers/spi/atmel-quadspi.c
> > +++ b/drivers/spi/atmel-quadspi.c
> > @@ -616,6 +616,8 @@ static int atmel_qspi_transfer(struct atmel_qspi *aq,
> >                              const struct spi_mem_op *op, u32 offset)
> >  {
> >       u32 sr, imr;
> > +     uint32_t val = 0;
> > +     unsigned long timeout;
> >
> >       /* Skip to the final steps if there is no data */
> >       if (op->data.nbytes) {
> > @@ -636,8 +638,19 @@ static int atmel_qspi_transfer(struct atmel_qspi
> *aq,
> >
> >       /* Poll INSTruction End and Chip Select Rise flags. */
> >       imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
> > -     return readl_poll_timeout(aq->regs + QSPI_SR, sr, (sr & imr) ==
> imr,
> > -                               ATMEL_QSPI_TIMEOUT);
> > +
> > +     timeout = timer_get_us() + ATMEL_QSPI_TIMEOUT;
> > +     while(1){
>
> There is a missing space, can you please run checkpatch tool and fix the
> warnings given ?
>
> > +             val |= readl( aq->regs + QSPI_SR ) & imr;
> > +             if( ( val & imr ) == imr ){
>
> Remove unnecessary brackets please, also spacing is odd
>
> > +                     return 0;
> > +             }
> > +
> > +             if ( time_after(timer_get_us(), timeout)) {
> Same here
> > +                     return -ETIMEDOUT;
> > +             }
> > +     }
> > +
> >  }
> >
> >  static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
>
>
> Eugen
>

--000000000000bab8aa063a5af0a1
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-arm-spi-atmel_qspi-fix-race-condition-in-transfer-co.patch"
Content-Disposition: attachment; 
	filename="0001-arm-spi-atmel_qspi-fix-race-condition-in-transfer-co.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mdbm4vfa0>
X-Attachment-Id: f_mdbm4vfa0

RnJvbSBmODAxZGM2Nzk1MGY5YzA2ZDY0YzVhMjVmMWZkMmNiMzc3YzA0OTE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1pbiBNb3Vzc2F2aSA8bG9yZHJhc211c0BnbWFpbC5jb20+
CkRhdGU6IFN1biwgMTMgSnVsIDIwMjUgMTc6NDM6MzEgKzAyMDAKU3ViamVjdDogW1BBVENIXSBh
cm06IHNwaTogYXRtZWxfcXNwaTogZml4IHJhY2UgY29uZGl0aW9uIGluIHRyYW5zZmVyCiBjb21w
bGV0aW9uIGNoZWNrCgpJbiBhdG1lbF9xc3BpX3RyYW5zZmVyKCksIHRoZSBzdGF0dXMgcmVnaXN0
ZXIgaXMgcG9sbGVkIHdpdGg6CgogIGltciA9IFFTUElfU1JfSU5TVFJFIHwgUVNQSV9TUl9DU1I7
CiAgcmV0dXJuIHJlYWRsX3BvbGxfdGltZW91dChhcS0+cmVncyArIFFTUElfU1IsIHNyLAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKHNyICYgaW1yKSA9PSBpbXIsCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBBVE1FTF9RU1BJX1RJTUVPVVQpOwoKSG93ZXZlciwgdGhpcyBpcyByYWN5
OiBRU1BJX1NSX0lOU1RSRSBjYW4gYmUgc2V0IGJlZm9yZSBRU1BJX1NSX0NTUiwKYW5kIHdpbGwg
dGhlbiBiZSBjbGVhcmVkIGJ5IHRoZSByZWFkLiBJZiB0aGF0IGhhcHBlbnMsIHRoZSBjb25kaXRp
b24KIihzciAmIGltcikgPT0gaW1yIiBjYW4gbmV2ZXIgYmUgdHJ1ZSwgYW5kIHRoZSBmdW5jdGlv
biB0aW1lcyBvdXQuCgpUaGlzIHJhY2UgY29uZGl0aW9uIGlzIGF2b2lkZWQgaW4gYXQ5MWJvb3Rz
dHJhcCBieSBhY2N1bXVsYXRpbmcgdGhlCnN0YXR1cyBiaXRzIGFjcm9zcyByZWFkcyB1bnRpbCBi
b3RoIGJpdHMgaGF2ZSBiZWVuIG9ic2VydmVkOgoKICAvKiBQb2xsIElOU1RydWN0aW9uIEVuZCBh
bmQgQ2hpcCBTZWxlY3QgUmlzZSBmbGFncy4gKi8KICBpbXIgPSAoUVNQSV9TUl9JTlNUUkUgfCBR
U1BJX1NSX0NTUik7CiAgc3IgPSAwOwogIGRvIHsKICAgIHVkZWxheSgxKTsKICAgIHNyIHw9IHFz
cGlfcmVhZGwocXNwaSwgUVNQSV9TUikgJiBpbXI7CiAgfSB3aGlsZSAoKC0tdGltZW91dCkgJiYg
KHNyICE9IGltcikpOwoKVXBkYXRlIFUtQm9vdCdzIGF0bWVsX3FzcGlfdHJhbnNmZXIoKSB0byB1
c2UgdGhlIHNhbWUgcGF0dGVybiwKZW5zdXJpbmcgdGhhdCBib3RoIGZsYWdzIGFyZSBvYnNlcnZl
ZCBldmVuIGlmIHRoZXkgYXJlIG5vdCBzZXQKc2ltdWx0YW5lb3VzbHkuCgpTaWduZWQtb2ZmLWJ5
OiBSYW1pbiBNb3Vzc2F2aSA8bG9yZHJhc211c0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9zcGkv
YXRtZWwtcXVhZHNwaS5jIHwgMTQgKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL2F0
bWVsLXF1YWRzcGkuYyBiL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYwppbmRleCA4YWE3YTgz
YWVmNC4uMGY5Y2U0MDlhMGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGku
YworKysgYi9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMKQEAgLTYxNiw2ICs2MTYsOCBAQCBz
dGF0aWMgaW50IGF0bWVsX3FzcGlfdHJhbnNmZXIoc3RydWN0IGF0bWVsX3FzcGkgKmFxLAogCQkJ
ICAgICAgIGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCwgdTMyIG9mZnNldCkKIHsKIAl1MzIg
c3IsIGltcjsKKwl1MzIgdmFsID0gMDsKKwl1bnNpZ25lZCBsb25nIHRpbWVvdXQ7CiAKIAkvKiBT
a2lwIHRvIHRoZSBmaW5hbCBzdGVwcyBpZiB0aGVyZSBpcyBubyBkYXRhICovCiAJaWYgKG9wLT5k
YXRhLm5ieXRlcykgewpAQCAtNjM2LDggKzYzOCwxNiBAQCBzdGF0aWMgaW50IGF0bWVsX3FzcGlf
dHJhbnNmZXIoc3RydWN0IGF0bWVsX3FzcGkgKmFxLAogCiAJLyogUG9sbCBJTlNUcnVjdGlvbiBF
bmQgYW5kIENoaXAgU2VsZWN0IFJpc2UgZmxhZ3MuICovCiAJaW1yID0gUVNQSV9TUl9JTlNUUkUg
fCBRU1BJX1NSX0NTUjsKLQlyZXR1cm4gcmVhZGxfcG9sbF90aW1lb3V0KGFxLT5yZWdzICsgUVNQ
SV9TUiwgc3IsIChzciAmIGltcikgPT0gaW1yLAotCQkJCSAgQVRNRUxfUVNQSV9USU1FT1VUKTsK
KworCXRpbWVvdXQgPSB0aW1lcl9nZXRfdXMoKSArIEFUTUVMX1FTUElfVElNRU9VVDsKKwl3aGls
ZSAoMSkgeworCQl2YWwgfD0gcmVhZGwoYXEtPnJlZ3MgKyBRU1BJX1NSKSAmIGltcjsKKwkJaWYg
KCh2YWwgJiBpbXIpID09IGltcikKKwkJCXJldHVybiAwOworCisJCWlmICh0aW1lX2FmdGVyKHRp
bWVyX2dldF91cygpLCB0aW1lb3V0KSkKKwkJCXJldHVybiAtRVRJTUVET1VUOworCX0KIH0KIAog
c3RhdGljIGludCBhdG1lbF9xc3BpX3NhbWE3ZzVfc2V0X2NmZyhzdHJ1Y3QgYXRtZWxfcXNwaSAq
YXEsCi0tIAoyLjUwLjEKCg==
--000000000000bab8aa063a5af0a1--
