Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04BFD462A4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CBE089119;
	Wed, 13 Nov 2024 15:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HGHab+pY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB218935C; Wed, 13 Nov 2024 15:02:49 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2EF88B0A
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e3fca72a41so5562664a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731506565; x=1732111365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rTiglDEgsH5od2eH980xaWy0DRhvvCK+N0oZh/lG3QM=;
 b=HGHab+pYQ4HxlexYuCTq7Iuymg6/IEdPeMRJEhU0H6M0dXNXkNoMrYNomALaPcWNWW
 8nqbEGGCTjxsvYE8dF6lgvz4E17TjljvV9pp+GMRw9zhchLIOdCUBCAsnGhGw2nfTlwB
 XVoZumeFtBWq6m+A8r9Zi6EYRGSlFgULqGpqITx+2MIRh53iZ0mHrp4xPfOpqIC6Y6FJ
 Hx8F5j1bXDXPpAQdZ2z4xJRyRoeKEsffZGXwVCVwdN9YKyY4J2oL32tvYX8zk1+/yvtD
 G3exnV9umqFO8YU0puW5d2UX12XAgHkhl07C+AcWZWLWCrSoA+hNvGRb5DokmzzL8s6+
 JvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731506565; x=1732111365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rTiglDEgsH5od2eH980xaWy0DRhvvCK+N0oZh/lG3QM=;
 b=ZEKenTrOeb34P9msPY0Wu9EGcGbBNtJ96BXYjoXuKQkeek5a99HuNabwYa99dXRenK
 0HCJYUQ0dyBZUaoQmvFzOWSFlCEwc8261ZWUQVKDCxzIZC50ZeS6dOz3T+D1YE3Xa2Mt
 hAm2dYnvPeHIcW6D71tUkbGzNHY7xb8s8HvTcirYL07gPNj15X73zb4jQvomJ+oZNxfM
 7NQ9p0UxvtcVM9ArRA4xCHSqjLq7LONywj8Pc3iK0AUbDKDc+o5kyJ5C4HLzfJ1MKOMO
 dwMwLq0l9s3GN9vDnmeCOkbtIPHXyJuqBzz88hMOhPTn1Wjo1lKj+KSYN5/yJRmBsNGF
 0v6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB5fHEqOZrU3gQug4al4jYCqdn7+h2iObwyX4Yk6ljqRILkh9g39XTN0jrRCVJpzVl54CyVzo=@lists.denx.de
X-Gm-Message-State: AOJu0YwlZOwn1pprikpPH2HZzIYie2cCLgvr5eb4FO2oKNU0KplEdigI
 ebNh9A4P4ExMbPskWnYt4sz5cVR91ddLUGcprIJysZqaeIPmOAe+/O400bFAeeVwNRMx6Yxhusk
 ivJhvk9RbaVkSNnEP1nFjXcN/S88=
X-Google-Smtp-Source: AGHT+IEl+hAOsxQqAnSnaiB1VYpE6SHgdq4JFuBlGcvNkTz3X+UaJdT/CdPTkWJE7StfpT+VIBS7QTDmbqQlZZqH4k0=
X-Received: by 2002:a17:90b:1dd1:b0:2e2:ba35:3573 with SMTP id
 98e67ed59e1d1-2e9f2c900b7mr3599314a91.20.1731506565016; Wed, 13 Nov 2024
 06:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-11-adrianox@gmail.com>
 <49ee4d70-3c1c-443f-b778-1e50e8430487@gmx.de>
In-Reply-To: <49ee4d70-3c1c-443f-b778-1e50e8430487@gmx.de>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 13 Nov 2024 11:02:33 -0300
Message-ID: <CAMGU2hWWPUDGpePwW1KJZtewNeTo5WnXvsGAx_Urt0RRcC6UUg@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] efi_loader: net: add support to send http
 requests and parse http headers
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

El mar, 12 nov 2024 a las 10:51, Heinrich Schuchardt (<xypron.glpk@gmx.de>)
escribi=C3=B3:

> On 11.11.24 22:09, Adriano Cordova wrote:
> > Add network-stack agnostic way to send an http request and
> > parse http headers from efi drivers. This uses wget as a
> > backend and communicates with it via efi_wget_info.
> >
> > The function efi_net_do_request allocates a buffer on behalf of an
> > efi application using efi_alloc and passes it to wget to receive
> > the data. If the method is GET and the buffer is too small, it
> > re-allocates the buffer based on the last received Content-Length
> > header and tries again. If the method is HEAD it just issues one
> > request. So issuing a HEAD request (to update Content-Length) and
> > then a GET request is preferred but not required.
> >
> > The function efi_net_parse_headers parses a raw buffer containing
> > an http header into an array of EFI specific 'http_header' structs.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >
> > Changes in v3:
> > - Add a struct wget_http_info efi_wget_info for efi_net to pass to wget
> >    when issuing wget requests, instead of using the old wget_info (see =
v2
> >    of the series 'wget: Expose wget to applications').
> > - Let a pointer to the http status code be passed to efi_net_do_request
> >    for it to fill it for the client after a request.
> >
> >   include/efi_loader.h     |  13 ++++
> >   lib/efi_loader/efi_net.c | 158 ++++++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 171 insertions(+)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index f49f8e6be0..4d05c08441 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -16,6 +16,7 @@
> >   #include <image.h>
> >   #include <pe.h>
> >   #include <linux/list.h>
> > +#include <linux/sizes.h>
> >   #include <linux/oid_registry.h>
> >
> >   struct blk_desc;
> > @@ -136,6 +137,18 @@ void efi_net_get_addr(struct efi_ipv4_address *ip,
> >   void efi_net_set_addr(struct efi_ipv4_address *ip,
> >                     struct efi_ipv4_address *mask,
> >                     struct efi_ipv4_address *gw);
> > +efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method,
> ulong *buffer,
> > +                             u32 *status_code, ulong *file_size, char
> *headers_buffer);
> > +#define MAX_HTTP_HEADERS_SIZE SZ_64K
> > +#define MAX_HTTP_HEADERS 100
> > +#define MAX_HTTP_HEADER_NAME 128
> > +#define MAX_HTTP_HEADER_VALUE 512
> > +struct http_header {
> > +     uchar name[MAX_HTTP_HEADER_NAME];
> > +     uchar value[MAX_HTTP_HEADER_VALUE];
> > +};
> > +
> > +void efi_net_parse_headers(ulong *num_headers, struct http_header
> *headers);
> >   #else
> >   static inline void efi_net_set_dp(const char *dev, const char *server=
)
> { }
> >   static inline void efi_net_get_dp(void **dp) { }
> > diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> > index d4570d4d7c..30234ae1c7 100644
> > --- a/lib/efi_loader/efi_net.c
> > +++ b/lib/efi_loader/efi_net.c
> > @@ -17,6 +17,7 @@
> >
> >   #include <efi_loader.h>
> >   #include <dm.h>
> > +#include <linux/sizes.h>
> >   #include <malloc.h>
> >   #include <vsprintf.h>
> >   #include <net.h>
> > @@ -34,6 +35,12 @@ static int rx_packet_num;
> >   static struct efi_net_obj *netobj;
> >   static struct efi_device_path *net_dp;
> >
> > +static struct wget_http_info efi_wget_info =3D {
> > +     .set_bootdev =3D false,
> > +     .check_buffer_size =3D true,
> > +
> > +};
> > +
> >   /*
> >    * The notification function of this event is called in every timer
> cycle
> >    * to check if a new network packet has been received.
> > @@ -1003,6 +1010,10 @@ out_of_resources:
> >       return EFI_OUT_OF_RESOURCES;
> >   }
> >
> > +/**
> > + * efi_net_set_dp() - set device path of efi net device
> > + *
> > + */
> >   void efi_net_set_dp(const char *dev, const char *server)
> >   {
> >       if (!strcmp(dev, "Net"))
> > @@ -1011,6 +1022,10 @@ void efi_net_set_dp(const char *dev, const char
> *server)
> >               net_dp =3D efi_dp_from_http(server);
> >   }
> >
> > +/**
> > + * efi_net_set_dp() - get device path of efi net device
> > + *
> > + */
> >   void efi_net_get_dp(void **dp)
> >   {
> >       if (!net_dp)
> > @@ -1019,6 +1034,10 @@ void efi_net_get_dp(void **dp)
> >               *dp =3D efi_dp_dup(net_dp);
> >   }
> >
> > +/**
> > + * efi_net_get_addr() - get IP address information
> > + *
> > + */
> >   void efi_net_get_addr(struct efi_ipv4_address *ip,
> >                     struct efi_ipv4_address *mask,
> >                     struct efi_ipv4_address *gw)
> > @@ -1068,6 +1087,10 @@ void efi_net_get_addr(struct efi_ipv4_address *i=
p,
> >   #endif
> >   }
> >
> > +/**
> > + * efi_net_set_addr() - set IP address information
> > + *
> > + */
> >   void efi_net_set_addr(struct efi_ipv4_address *ip,
> >                     struct efi_ipv4_address *mask,
> >                     struct efi_ipv4_address *gw)
> > @@ -1117,3 +1140,138 @@ void efi_net_set_addr(struct efi_ipv4_address
> *ip,
> >               memcpy((void *)&net_netmask, (void *)mask, 4);
> >   #endif
> >   }
> > +
> > +/**
> > + * efi_net_set_buffer() - allocate a buffer of min 64K
>
> Please, describe the parameters.
>
> > + *
> > + */
> > +static efi_status_t efi_net_set_buffer(ulong *buffer, ulong size)
>
> Please, use size_t for sizes.
>
> All invocations use size =3D 0. So we should drop the parameter.
>

Some invocations still use it

> +{
> > +     efi_status_t ret =3D EFI_SUCCESS;
> > +
> > +     if (size < SZ_64K)
> > +             size =3D SZ_64K;
> > +
> > +     efi_free_pool((void *)*buffer);
> > +
> > +     *buffer =3D (ulong)efi_alloc(size);
>
> efi_alloc() returns a pointer.
>
> There is no good reason to store pointers in ulong. Please, use void *
> for pointers.
>

Makes sense, I will change it. But wget uses ulong for now, so I still cast
to ulong before calling wget.


> Patch 13/15 shows the resulting confusion:
>
> In efi_http_send_data() you assume http_load_addr is a sandbox virtual
> address:
>
>    ptr =3D map_sysmem(inst->http_load_addr + inst->current_offset,
> transfer_size);
>
> And a few lines below you assume that it is a pointer:
>
>    efi_free_pool((void *)inst->http_load_addr);
>
> We should keep sandbox specific addresses which need map_sysmem() and
> map_to_sysmem() out of the EFI implementation as far as possible.
>
> So let parameter buffer be of type **void here.
>
> We need a test that we can run both on the sandbox and on Q
>
> > +     if (!*buffer)
> > +             ret =3D EFI_OUT_OF_RESOURCES;
> > +
> > +     efi_wget_info.buffer_size =3D size;
> > +     //debug("efi_net: set buffer of size %lu at %lu\n", size, *buffer=
);
>
> It would be fine to have a debug statement here but, please, remove
> lines that only where used during your development process.
>
> Nits:
> As described in doc/develop/codingstyle.rst:224:
>
> "* Put a blank line before the last ``return`` in a function unless it
> is the only line:"
>
> > +     return ret;
> > +}
> > +
> > +/**
> > + * efi_net_parse_headers() - parse HTTP headers
> > + *
> > + * Parses the raw buffer efi_wget_info.headers into an array headers
> > + * of efi structs http_headers. The array should be at least
> > + * MAX_HTTP_HEADERS long.
>
> Please, describe the parameters.
>
> > + */
> > +void efi_net_parse_headers(ulong *num_headers, struct http_header
> *headers)
> > +{
> > +     if (!num_headers || !headers)
> > +             return;
> > +
> > +     // Populate info with http headers.
> > +     *num_headers =3D 0;
> > +     const uchar *line_start =3D efi_wget_info.headers;
> > +     const uchar *line_end;
> > +     ulong count;
> > +     struct http_header *current_header;
> > +     const uchar *separator;
> > +     size_t name_length, value_length;
> > +
> > +     // Skip the first line (request or status line)
> > +     line_end =3D strstr(line_start, "\r\n");
> > +
> > +     if (line_end)
> > +             line_start =3D line_end + 2;
> > +
> > +     while ((line_end =3D strstr(line_start, "\r\n")) !=3D NULL) {
> > +             count =3D *num_headers;
> > +             if (line_start =3D=3D line_end || count >=3D MAX_HTTP_HEA=
DERS)
> > +                     break;
> > +             current_header =3D headers + count;
> > +             separator =3D strchr(line_start, ':');
> > +             if (separator) {
> > +                     name_length =3D separator - line_start;
> > +                     ++separator;
> > +                     while (*separator =3D=3D ' ')
> > +                             ++separator;
> > +                     value_length =3D line_end - separator;
> > +                     if (name_length < MAX_HTTP_HEADER_NAME &&
> > +                         value_length < MAX_HTTP_HEADER_VALUE) {
> > +                             strncpy(current_header->name, line_start,
> name_length);
> > +                             current_header->name[name_length] =3D '\0=
';
> > +                             strncpy(current_header->value, separator,
> value_length);
> > +                             current_header->value[value_length] =3D '=
\0';
> > +                             (*num_headers)++;
> > +                     }
> > +             }
> > +             line_start =3D line_end + 2;
> > +     }
> > +}
> > +
> > +/**
> > + * efi_net_do_request() - issue an HTTP request using wget
>
> Please, complete the function description.
>
> > + *
> > + */
> > +efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method,
> ulong *buffer,
>
> Please, use void **buffer. Below you are assuming *buffer is a pointer
> and not a sandbox virtual address.
>
> > +                             u32 *status_code, ulong *file_size, char
> *headers_buffer)
> > +{
> > +     efi_status_t ret =3D EFI_SUCCESS;
> > +     int wget_ret;
> > +     static bool last_head;
> > +
> > +     if (!buffer || !file_size)
> > +             return EFI_ABORTED;
> > +
> > +     efi_wget_info.method =3D (enum wget_http_method)method;
>
> Parameter method has type 'enum wget_http_method'. Please, remove the
> superfluous conversion.
>
> Parameter has type efi_http_method (efi_api.h), not wget_http_method
(net-common.h). These enums are the
same, I didn't want to expose the efi api to wget, but I could.


> Best regards
>
> Heinrich
>
> > +     efi_wget_info.headers =3D headers_buffer;
> > +
> > +     switch (method) {
> > +     case HTTP_METHOD_GET:
> > +             ret =3D efi_net_set_buffer(buffer, last_head ?
> efi_wget_info.hdr_cont_len : 0);
> > +             if (ret !=3D EFI_SUCCESS)
> > +                     goto out;
> > +             wget_ret =3D wget_request((ulong)*buffer, url,
> &efi_wget_info);
> > +             if ((ulong)efi_wget_info.hdr_cont_len >
> efi_wget_info.buffer_size) {
> > +                     // Try again with updated buffer size
> > +                     ret =3D efi_net_set_buffer(buffer,
> (ulong)efi_wget_info.hdr_cont_len);
> > +                     if (ret !=3D EFI_SUCCESS)
> > +                             goto out;
> > +                     if (wget_request((ulong)*buffer, url,
> &efi_wget_info)) {
> > +                             efi_free_pool((void *)*buffer);
> > +                             ret =3D EFI_DEVICE_ERROR;
> > +                             goto out;
> > +                     }
> > +             } else if (wget_ret) {
> > +                     efi_free_pool((void *)*buffer);
> > +                     ret =3D EFI_DEVICE_ERROR;
> > +                     goto out;
> > +             }
> > +             // Pass the actual number of received bytes to the
> application
> > +             *file_size =3D efi_wget_info.file_size;
> > +             *status_code =3D efi_wget_info.status_code;
> > +             last_head =3D false;
> > +             break;
> > +     case HTTP_METHOD_HEAD:
> > +             ret =3D efi_net_set_buffer(buffer, 0);
> > +             if (ret !=3D EFI_SUCCESS)
> > +                     goto out;
> > +             wget_request((ulong)*buffer, url, &efi_wget_info);
> > +             *file_size =3D 0;
> > +             *status_code =3D efi_wget_info.status_code;
> > +             last_head =3D true;
> > +             break;
> > +     default:
> > +             ret =3D EFI_UNSUPPORTED;
> > +             break;
> > +     }
> > +
> > +out:
> > +     return ret;
> > +}
>
>
