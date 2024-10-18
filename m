Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7D6D30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2EF892A2;
	Fri, 18 Oct 2024 17:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mh0WXxif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 720F589262; Fri, 18 Oct 2024 17:01:29 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6180B89261
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2dc61bc41so1594250a91.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263677; x=1729868477; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=okRYT8hBSezbWqePoELOLAE40+eUg2XZ5B8BmGIaFkw=;
 b=mh0WXxifVeq4ZMaZHwLcQtuXzSxNlf0ckfngVJrBFuWYDiiSXqo9pMEZKm48uyeHCA
 O4Nvnf0RqT2V7v45kz8o2mrYn3yR4N2WjMdqp0plvRx5xRfCcvo8WE5fucTEApLDVism
 zMvWaN1OJDIi03eDybzY/7aMOtcuAYzdl72B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263677; x=1729868477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=okRYT8hBSezbWqePoELOLAE40+eUg2XZ5B8BmGIaFkw=;
 b=ZEn0hh1b3+ucIEWvhPWNeoWtccANOjRbhdd6xAvVKVT5NLz2OAaqh6LjAAER+8qzX5
 DAqpcO1hdXKxqbuXHnoTC/nw5qfQe5IznI/fLz1gzohSXu7Mm6YqhNCpfQHL0eYrE123
 GLsA62gzfLjLyuHxhpaWSjZ9TTv/BAp49lXr8JkbHkqjFWdDl1dTP8xAPgJfhwFgYjvx
 IjaggzTxDRbwJTg+Rt6M5EsXAdgDTiSumgSl4UyIgh3IpaiIaZmgxfzCb4zlgqlhkJh8
 it3xECyaulXv9M9ewE7bvK9oXB3MVeBQ8alyulrVg9UmRKSw4XNpbdFAVTYbHdCC+/pW
 9Vrw==
X-Gm-Message-State: AOJu0YwoCcqZnWAvvovhhT05IyYal1zG7LJeRLP1q7nDOIy0jKr7t97z
 Ab0gWH8boF7LJMseRaWTq2zEyqhu4bv0TC8IfK5H4bhmmjCdywy4AmfkkbBnom8YUPcfmyxyk5J
 cAg+Vbv2yvZaZlb+zZJaeLIBUTXN1BUIgcSOW
X-Google-Smtp-Source: AGHT+IEgTWNFH4ijnIKo2ox0Zj9YKOVOv7F4unEvR89L+bFTJkDp5FN5e+1GgSeugahua7Qn65bIq6IYfV0Bu+TrhzM=
X-Received: by 2002:a17:90b:3bcd:b0:2e2:d3f6:6efc with SMTP id
 98e67ed59e1d1-2e5618cec6amr3168075a91.28.1729263676817; Fri, 18 Oct 2024
 08:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-24-sjg@chromium.org>
 <0B48F871-BDD8-4810-ADA3-4F6C4E403B0C@gmx.de>
In-Reply-To: <0B48F871-BDD8-4810-ADA3-4F6C4E403B0C@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 09:01:03 -0600
Message-ID: <CAFLszTjF-kg5E+sV+CkFjStmS2YyJiPa59zOWWZxd2J5yOwftA@mail.gmail.com>
Subject: Re: [PATCH 23/34] bootstd: Maintain a list of images
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >We want to keep track of images which are loaded, or those which could
> >perhaps be loaded. This will make it easier to manage memory allocation,
> >as well as permit removal of the EFI set_efi_bootdev() hack.

I'll change this 'hack' to 'feature'.

>
> Please, keep in mind that files can be loaded manually, e.g. via the dhcp, the wget, and the loady commands. These are outside bootflows.

Yes, this series is only going to help if bootstd is used. For ad-hoc
use, EFI will need to rely on the above feature, at least until
someone can think of another solution.

>
> No matter how an EFI binary is loaded, we have to create the matching device path. This requires knowledge of the source device and the  filepath or URL. Please, ensure that you gather all necessary information.

OK I'll send a little series which shows how this can work. I had
thought it was understood already, but your comment helps explain why
no one has done it yet. In brief, the main advantage of bootstd over
the scripts is that it has a full understanding of what is going on.

>
> Best regards
>
> Heinrich
>
> >
> >Add a list of these, attached to the bootflow. For now the list is
> >empty.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> > boot/bootflow.c    |  7 +++++++
> > include/bootflow.h | 21 +++++++++++++++++++++
> > 2 files changed, 28 insertions(+)
> >
> >diff --git a/boot/bootflow.c b/boot/bootflow.c
> >index 72b51ebd49b..10bda8eac79 100644
> >--- a/boot/bootflow.c
> >+++ b/boot/bootflow.c
> >@@ -455,10 +455,13 @@ void bootflow_init(struct bootflow *bflow, struct udevice *bootdev,
> > bflow->dev = bootdev;
> > bflow->method = meth;
> > bflow->state = BOOTFLOWST_BASE;
> >+ alist_init_struct(&bflow->images, struct bootflow_img);
> > }
> >
> > void bootflow_free(struct bootflow *bflow)
> > {
> >+ struct bootflow_img *img;
> >+
> > free(bflow->name);
> > free(bflow->subdir);
> > free(bflow->fname);
> >@@ -467,6 +470,10 @@ void bootflow_free(struct bootflow *bflow)
> > free(bflow->os_name);
> > free(bflow->fdt_fname);
> > free(bflow->bootmeth_priv);
> >+
> >+ alist_for_each(img, &bflow->images)
> >+ free(img->fname);
> >+ alist_empty(&bflow->images);
> > }
> >
> > void bootflow_remove(struct bootflow *bflow)
> >diff --git a/include/bootflow.h b/include/bootflow.h
> >index 9b24fb5c3eb..3d9a9e2025a 100644
> >--- a/include/bootflow.h
> >+++ b/include/bootflow.h
> >@@ -7,7 +7,9 @@
> > #ifndef __bootflow_h
> > #define __bootflow_h
> >
> >+#include <alist.h>
> > #include <bootdev.h>
> >+#include <image.h>
> > #include <dm/ofnode_decl.h>
> > #include <linux/list.h>
> >
> >@@ -85,6 +87,7 @@ enum bootflow_flags_t {
> >  * @cmdline: OS command line, or NULL if not known (allocated)
> >  * @x86_setup: Pointer to x86 setup block inside @buf, NULL if not present
> >  * @bootmeth_priv: Private data for the bootmeth
> >+ * @images: List of loaded images (struct bootstd_img)
> >  */
> > struct bootflow {
> > struct udevice *dev;
> >@@ -109,6 +112,24 @@ struct bootflow {
> > char *cmdline;
> > void *x86_setup;
> > void *bootmeth_priv;
> >+ struct alist images;
> >+};
> >+
> >+/**
> >+ * struct bootflow_img - Information about an image which has been loaded
> >+ *
> >+ * This keeps track of a single, loaded image.
> >+ *
> >+ * @fname: Filename used to load the image (allocated)
> >+ * @type: Image type (IH_TYPE_...)
> >+ * @addr: Address to which the image was loaded, 0 if not yet loaded
> >+ * @size: Size of the image
> >+ */
> >+struct bootflow_img {
> >+ char *fname;
> >+ enum image_type_t type;
> >+ ulong addr;
> >+ ulong size;
> > };
> >
> > /**

Regards,
SImon
