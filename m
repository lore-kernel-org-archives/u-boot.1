Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6798E94115
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4629B86BE7;
	Fri,  6 Oct 2023 22:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IHgA30/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E0786C78; Fri,  6 Oct 2023 22:36:36 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E826286B02
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57d086365f7so1402773eaf.0
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624592; x=1697229392; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnuqO/0MQSPN54L3c3DsNcMMhjVPuJKgarxuTEX0F08=;
 b=IHgA30/0VYb9Ntz77flRaiwkttTQHlhcqtkroh8rYropX7v+hXL8hv1UbZ9YEDkBLz
 jWkvyvYeCTLZyFZ1FUTmXo6cA7bEukfEUkxDqohBbEmCyyjjsMQZn0b+xl/5yM/bemgc
 ypeYHN9m6ccYq3mxsgq/UbyPpHqKjZFdJJ8tOM/n48MzUtTbg8UQkKTz8A9flhgkYmOn
 5KBPhPsKMhX0si/WDNQy894q36fVVSAtELxpr30jUMO3OHhKpDqvU6Yz8RGBIu9Mer9y
 3re/HlIVIDKTQi4oyq0TKo0JQXCuGX3DKM1PnfcL7CI9vm1pBJamdKF26uQSzFgQ6mdL
 ZVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624592; x=1697229392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnuqO/0MQSPN54L3c3DsNcMMhjVPuJKgarxuTEX0F08=;
 b=DOio9YBOZUWvH7mksjUUEU44xJ0ndgZmj/X99oyK2CRTf7SosrLx+f6UH2M5ZwUtgG
 PImSV3ZhxlMaLZf72YkhnRPxT8MdMktmNn93zLsV/3tVN1d9MnHKXyVv4ZGv2kvOl4fe
 Qk+Ie2ywNjTmfmYSFMNGTPFpL5gRnoqnR2tv1lRFOkdXFo0pqOz9x3fEEom056PTmJPt
 ChtWkAZfdGB0DPV6Ps4oK6sIYzAaxwIh7omsAikLA1h+4xm1qMlhMDWtENtDDrKR2tK+
 jLY/uxgQQwymY7KG3PqR467DlJ5BG53HeTGXEwJlrUF2mXipqq7aF0H8sRjx6LeoAlp5
 Ou2A==
X-Gm-Message-State: AOJu0YwQlNBKgA6TEkbzSOGHN7BUEs0CETIKSXIhUEtlhuGvp4zTaVd0
 OndJlgxgvF3nsXFwvv37jZVTFPoE6WlZUBRl6uzLEkR5MjWOFg==
X-Google-Smtp-Source: AGHT+IHOZBstp/97V9JiQaeXOY7F/bWochfZ+jpvbCtmA4r4aHB+pzN1bITx5I4CDqYJb/AN8BHWYFCI7oz80VihB4g=
X-Received: by 2002:a4a:9b11:0:b0:573:bf68:8dbc with SMTP id
 a17-20020a4a9b11000000b00573bf688dbcmr8848649ook.7.1696624592433; Fri, 06 Oct
 2023 13:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
 <20230927093631.1595494-2-masahisa.kojima@linaro.org>
In-Reply-To: <20230927093631.1595494-2-masahisa.kojima@linaro.org>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:36:21 +0300
Message-ID: <CAGi-RUKdtkiB-GMRccrCbpMg5auqJOdo13CJP2+SaBEtwXb9oA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] net: wget: prevent overwriting reserved memory
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>
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

On Wed, Sep 27, 2023 at 12:37=E2=80=AFPM Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This introduces the valid range check to store the received
> blocks using lmb. The same logic is implemented in tftp.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  net/wget.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 73 insertions(+), 7 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index 2dbfeb1a1d..a48a8cb624 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -4,16 +4,20 @@
>   * Copyright Duncan Hare <dh@synoia.com> 2017
>   */
>
> +#include <asm/global_data.h>
>  #include <command.h>
>  #include <common.h>
>  #include <display_options.h>
>  #include <env.h>
>  #include <image.h>
> +#include <lmb.h>
>  #include <mapmem.h>
>  #include <net.h>
>  #include <net/tcp.h>
>  #include <net/wget.h>
>
> +DECLARE_GLOBAL_DATA_PTR;
> +
>  static const char bootfile1[] =3D "GET ";
>  static const char bootfile3[] =3D " HTTP/1.0\r\n\r\n";
>  static const char http_eom[] =3D "\r\n\r\n";
> @@ -55,6 +59,29 @@ static unsigned int retry_tcp_ack_num;       /* TCP re=
try acknowledge number*/
>  static unsigned int retry_tcp_seq_num; /* TCP retry sequence number */
>  static int retry_len;                  /* TCP retry length */
>
> +static ulong wget_load_size;
> +
> +/**
> + * wget_init_max_size() - initialize maximum load size
> + *
> + * Return:     0 if success, -1 if fails
> + */
> +static int wget_init_load_size(void)
> +{
> +       struct lmb lmb;
> +       phys_size_t max_size;
> +
> +       lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
> +
> +       max_size =3D lmb_get_free_size(&lmb, image_load_addr);
> +       if (!max_size)
> +               return -1;
> +
> +       wget_load_size =3D max_size;
> +
> +       return 0;
> +}
> +
>  /**
>   * store_block() - store block in memory
>   * @src: source of data
> @@ -63,10 +90,25 @@ static int retry_len;                       /* TCP re=
try length */
>   */
>  static inline int store_block(uchar *src, unsigned int offset, unsigned =
int len)
>  {
> +       ulong store_addr =3D image_load_addr + offset;
>         ulong newsize =3D offset + len;
>         uchar *ptr;
>
> -       ptr =3D map_sysmem(image_load_addr + offset, len);
> +       if (IS_ENABLED(CONFIG_LMB)) {
> +               ulong end_addr =3D image_load_addr + wget_load_size;
> +
> +               if (!end_addr)
> +                       end_addr =3D ULONG_MAX;
> +
> +               if (store_addr < image_load_addr ||
> +                   store_addr + len > end_addr) {
> +                       printf("\nwget error: ");
> +                       printf("trying to overwrite reserved memory...\n"=
);
> +                       return -1;
> +               }
> +       }
> +
> +       ptr =3D map_sysmem(store_addr, len);
>         memcpy(ptr, src, len);
>         unmap_sysmem(ptr);
>
> @@ -240,25 +282,39 @@ static void wget_connected(uchar *pkt, unsigned int=
 tcp_seq_num,
>
>                         net_boot_file_size =3D 0;
>
> -                       if (len > hlen)
> -                               store_block(pkt + hlen, 0, len - hlen);
> +                       if (len > hlen) {
> +                               if (store_block(pkt + hlen, 0, len - hlen=
) !=3D 0) {
> +                                       wget_loop_state =3D NETLOOP_FAIL;
> +                                       wget_fail("wget: store error\n", =
tcp_seq_num, tcp_ack_num, action);
> +                                       net_set_state(NETLOOP_FAIL);
> +                                       return;
> +                               }
> +                       }
>
>                         debug_cond(DEBUG_WGET,
>                                    "wget: Connected Pkt %p hlen %x\n",
>                                    pkt, hlen);
>
>                         for (i =3D 0; i < pkt_q_idx; i++) {
> +                               int err;
> +
>                                 ptr1 =3D map_sysmem(
>                                         (phys_addr_t)(pkt_q[i].pkt),
>                                         pkt_q[i].len);
> -                               store_block(ptr1,
> -                                           pkt_q[i].tcp_seq_num -
> -                                           initial_data_seq_num,
> -                                           pkt_q[i].len);
> +                               err =3D store_block(ptr1,
> +                                         pkt_q[i].tcp_seq_num -
> +                                         initial_data_seq_num,
> +                                         pkt_q[i].len);
>                                 unmap_sysmem(ptr1);
>                                 debug_cond(DEBUG_WGET,
>                                            "wget: Connctd pkt Q %p len %x=
\n",
>                                            pkt_q[i].pkt, pkt_q[i].len);
> +                               if (err) {
> +                                       wget_loop_state =3D NETLOOP_FAIL;
> +                                       wget_fail("wget: store error\n", =
tcp_seq_num, tcp_ack_num, action);
> +                                       net_set_state(NETLOOP_FAIL);
> +                                       return;
> +                               }
>                         }
>                 }
>         }
> @@ -330,6 +386,7 @@ static void wget_handler(uchar *pkt, u16 dport,
>                                 len) !=3D 0) {
>                         wget_fail("wget: store error\n",
>                                   tcp_seq_num, tcp_ack_num, action);
> +                       net_set_state(NETLOOP_FAIL);
>                         return;
>                 }
>
> @@ -420,6 +477,15 @@ void wget_start(void)
>         debug_cond(DEBUG_WGET,
>                    "\nwget:Load address: 0x%lx\nLoading: *\b", image_load=
_addr);
>
> +       if (IS_ENABLED(CONFIG_LMB)) {
> +               if (wget_init_load_size()) {
> +                       printf("\nwget error: ");
> +                       printf("trying to overwrite reserved memory...\n"=
);
> +                       net_set_state(NETLOOP_FAIL);
> +                       return;
> +               }
> +       }
> +
>         net_set_timeout_handler(wget_timeout, wget_timeout_handler);
>         tcp_set_tcp_handler(wget_handler);
>
> --
> 2.34.1
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
