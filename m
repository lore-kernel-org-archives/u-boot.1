Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BA5C3DA6E
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 01:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E9C687725;
	Tue, 26 Dec 2023 02:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TLVcETZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A05877AA; Tue, 26 Dec 2023 02:13:23 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 389F486314
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 02:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a26db4e9676so214633266b.3
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 17:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703553199; x=1704157999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UZSW/DtR/NgzYTayefdcj69WYeFpLjB8NjlYYxUtr9A=;
 b=TLVcETZgXG5pRN7usi7wz670LFRe19cYnJw0YhC9Tza9WTN23aN3c8zvEdF0OnavTD
 u3dEJS2zKVXdmFJpa48r4ohIDzqJPny58UBIfh37f2Cc3zb1GHcsdjMDiYvlEmquwvV7
 vZHQ9Z0rFrX+b+2/Zgzk+U5hsaNl8w0yxrzojmhpaERpuJnO4xZcU3FD3gwqSVJdwFZ8
 cEuegCoVLATephqH2I19mkgeMq9AjSiBb2ra+VDQf0zYFL0kvZ6LEVYHzxtJ4n1ROPII
 ptB3D31pHARGKb0lqqlQ53BoyIDkZOPN4VTbgKg4rljp3ZdnSyzKXvLGrEqnkQTcVEfr
 roXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703553199; x=1704157999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZSW/DtR/NgzYTayefdcj69WYeFpLjB8NjlYYxUtr9A=;
 b=PDoDI8xx7RfeswF4vPWyZRuIo6aWqZQUIfJWXiVyUCvLA8DBpJUytr3D0hTs7U+8hG
 7dteLoJcOJdLqLZi/navGSPTANnEjgaQ3baZDXle05LkLfRbXwfJGjJE4mxlHBdfFBEM
 5QzJ04OuM6r1vw+Z4yje6mPalbOP55QcPo7WqCxnHbJP4VpMu0RxqWaC0LxRgdks9fo3
 kiQW3o60j/c6xzSY5UjBP7DlqxD7xDNZJQq62AkDZABAXK0z+b2MrS+Nr0tHV6hunqRs
 tgsEQ0wpTvRDLDq/SkBzgYFkHH1isvJDlBQKVE8BPhLLms9iPmvKrUfytWhx2ujueWiT
 HgpA==
X-Gm-Message-State: AOJu0YxbIrXXxGyjFhWVOvBjL2nd8VR83KpfZHmzlTRqgrHosZRD/B6H
 yNsGuZjTtzxR1Op2McAQ6x6okPfSE0A4cdSHOSuogawpbU8KLQ==
X-Google-Smtp-Source: AGHT+IEM6cEYa5cxEiQk/7iNr3lgPmSSHVVvdU/686A3s1IOIqqS27G759QiAfOu8RRHzt/CVb3uHNUytrwpMwdlfXM=
X-Received: by 2002:a17:906:25c3:b0:a24:f707:db70 with SMTP id
 n3-20020a17090625c300b00a24f707db70mr1493478ejb.131.1703553199610; Mon, 25
 Dec 2023 17:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20231225044356.626900-1-masahisa.kojima@linaro.org>
 <20231225044356.626900-3-masahisa.kojima@linaro.org>
 <585c8dd4-2fc9-44ff-b71b-ca1ad384c223@gmx.de>
In-Reply-To: <585c8dd4-2fc9-44ff-b71b-ca1ad384c223@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 26 Dec 2023 10:13:08 +0900
Message-ID: <CADQ0-X-LuZGHRGR=MkXEHaHg4p3ToBU2CbxkP9Phyw8sGCrBtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: avoid pointer access after calling
 efi_delete_handle
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Mon, 25 Dec 2023 at 19:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/25/23 05:43, Masahisa Kojima wrote:
> > efi_delete_handle() calls efi_purge_handle(), then it finally
> > frees the efi handle.
> > Both diskobj and handle variables in efi_disk_remove() have
> > the same pointer, we can not access diskobj->dp after calling
> > efi_delete_handle().
> >
> > This commit saves the struct efi_device_path pointer before
> > calling efi_delete_handle(). This commit also fixes the
> > missing free for volume member in struct efi_disk_obj.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >   lib/efi_loader/efi_disk.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index a2f8b531a3..415d8601ba 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -701,7 +701,9 @@ int efi_disk_remove(void *ctx, struct event *event)
> >       struct udevice *dev = event->data.dm.dev;
> >       efi_handle_t handle;
> >       struct blk_desc *desc;
> > +     struct efi_device_path *dp = NULL;
> >       struct efi_disk_obj *diskobj = NULL;
> > +     struct efi_simple_file_system_protocol *volume = NULL;
> >       efi_status_t ret;
> >
> >       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
> > @@ -722,14 +724,18 @@ int efi_disk_remove(void *ctx, struct event *event)
> >               return 0;
> >       }
> >
> > +     if (diskobj) {
>
>
>    diskobj = container_of(handle, struct efi_disk_obj, header);
>
> can be replaced by
>
>    diskobj = handle
>
> We should check the handle immediately after dev_tag_get_ptr() and
> return 0 if the handle == NULL.

OK, I will try to improve the efi_disk_remove() function.

>
> > +             dp = diskobj->dp;
> > +             volume = diskobj->volume;
> > +     }
> > +
> >       ret = efi_delete_handle(handle);
>
> We must not delete the handle in case of UCLASS_EFI_LOADER.
>
> Instead of calling efi_delete_handle we should uninstall all protocols
> that we have installed. If no protocol is left the handle will go away.
>
> To make the protocols to delete tractable they should be opened with
> BY_DRIVER.

efi_delete_handle() calls efi_remove_all_protocols(), and frees the efi handle
if no protocol is left on the handle.
So I think efi_delete_handle() does all the required processes mentioned above.

>
> When a partition is removed we must close the protocol interfaces opened
> with EFI_OPEN_PROTOCOL_BY_CHILD_CONTROLLER (cf. efi_disk_add_dev()).

OK, I will fix this.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> >       /* Do not delete DM device if there are still EFI drivers attached. */
> >       if (ret != EFI_SUCCESS)
> >               return -1;
> >
> > -     if (diskobj)
> > -             efi_free_pool(diskobj->dp);
> > -
> > +     efi_free_pool(dp);
> > +     free(volume);
> >       dev_tag_del(dev, DM_TAG_EFI);
> >
> >       return 0;
>
