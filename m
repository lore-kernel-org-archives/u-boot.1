Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21784D5E15A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 11:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEAD88EBA;
	Fri,  8 Nov 2024 12:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hnKRXwNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F4E8902D; Fri,  8 Nov 2024 12:19:31 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C773C88B0C
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 12:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso1386003a12.3
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 03:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731064767; x=1731669567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a/JLSZVKYuPQLX8dajX7L292531P8z4r6HOLMhO7x/Y=;
 b=hnKRXwNRcaCNNJybyBjK8uEpSpoJ1x7+JbSZjm+OQvXBytwx96c5LqdlUsGQfYEpQb
 zyMQu44DbbRGvYUvmtawAECwtBQqspnNpUfYXeIDmoAObRzm7mTaQuhVxu3NVQdyGDZr
 CAgmlWlgogxCa9UsPEUNTkl1PCzYGYAqfPwZrE8KH5fQlxShN5Y1jaTlCyq/s/qQalDu
 +KjDaHSj7yKwUFolnfuAExYRAPPS6p9ixNCguDrs15k30arNX3eBxRgRBnn0dfiZDkSV
 6jQqzVa6zi8PHduUFOT3hlmWkmvHsY6H7zKZqB+a3uzavPcjmP8H6T5KPDW5EU+kD676
 bi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731064767; x=1731669567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a/JLSZVKYuPQLX8dajX7L292531P8z4r6HOLMhO7x/Y=;
 b=RA7ugeRBxGwy0LCAjieaeFTdbXiE2FlRWSXk8avJyOX0bszwrEzASRwJnaN7CMNmjN
 9M2nhk0hnmfQc2O2pugQE7sue6QDtBW2HABFrg+fpin7WXhGZY3QzunR84mNbTqPyZkJ
 /m8F14rqfwq+tu8PqXJ1lmGGRttUIDH676biey8+0P3zKNhXArsYMg8uQ92r63+wECFi
 aPAfO87GJDlUqwHhc1LRZbDIQeRqyQdbQybVddmwpQ8oFoIrKk1tMi4vSLz35dd506X0
 t32Gnt5PNkqvNx85kOyE/+i6Q8T0Fj3fZlgU5AakQY0Upseh04HtdyGWNjAbh1oDt0Ar
 CXYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6QQ6EqGQxGaY/FNupnyXgVgxeKOr4J8NRKKW38C/LpChM1HA3YIDFQuv/60kuUsVlOHMAw7g=@lists.denx.de
X-Gm-Message-State: AOJu0YwMZiDeSy0irR19tjyt+RyIO7xIHPezRMOlqguMkmREN7VwCEVh
 7RWWNrdPF3ZHkmEIRuSPMqhvX0UFPUJ9aaq8uzVHs94Y/omRvv3gGKJNVNFiiKwYVgtL6w/u9/m
 EhE36Cw5yasVGfQczhjKZAjle2D2433u/lQMLSQ==
X-Google-Smtp-Source: AGHT+IGbH/h3Dy8eTbIsMBg1DJ5fM+b+e15ic4ZoGU6/rqFMEP58StY+EwbWiul6ZN/GQDb40FUtX97ozrv7vlaaWl8=
X-Received: by 2002:a17:90b:4b91:b0:2e1:d5c9:1bc4 with SMTP id
 98e67ed59e1d1-2e9b165595cmr3401620a91.7.1731064767185; Fri, 08 Nov 2024
 03:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-3-ilias.apalodimas@linaro.org>
 <d3d39673-61bc-4414-959b-1e9d2b10a55f@linaro.org>
In-Reply-To: <d3d39673-61bc-4414-959b-1e9d2b10a55f@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Nov 2024 11:18:51 +0000
Message-ID: <CAC_iWj+WPOis0HEDjsmKdU6=h0BwdoECYq7VE97srg190oz3ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] net: lwip: Update lwIP for mbedTLS > 3.0 support
 and enable https
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: raymond.mao@linaro.org, xypron.glpk@gmx.de, 
 Javier Tia <javier.tia@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Wed, 6 Nov 2024 at 13:37, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 10/24/24 12:24, Ilias Apalodimas wrote:
> > From: Javier Tia <javier.tia@linaro.org>
> >
> > The current code support mbedTLS 2.28. Since we are using a newer
> > version in U-Boot, update the necessary accessors and the lwIP codebase
> > to work with mbedTLS 3.6.0. It's worth noting that the patches are
> > already sent to lwIP [0]
> >
> > While at it enable LWIP_ALTCP_TLS and enable TLS support in lwIP
> >
> > [0] https://github.com/lwip-tcpip/lwip/pull/47
> >
> > Signed-off-by: Javier Tia <javier.tia@linaro.org>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  lib/lwip/Makefile                             |  3 ++
> >  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    | 39 ++++++++++++-------
> >  lib/lwip/lwip/src/core/tcp_out.c              | 10 +----
> >  lib/lwip/u-boot/lwipopts.h                    |  6 +++
> >  4 files changed, 34 insertions(+), 24 deletions(-)
> >
> > diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
> > index dfcd700ca474..19e5c6897f5a 100644
> > --- a/lib/lwip/Makefile
> > +++ b/lib/lwip/Makefile
> > @@ -53,3 +53,6 @@ obj-y += \
> >       lwip/src/core/timeouts.o \
> >       lwip/src/core/udp.o \
> >       lwip/src/netif/ethernet.o
> > +
> > +obj-$(CONFIG_MBEDTLS_LIB_TLS) += lwip/src/apps/altcp_tls/altcp_tls_mbedtls.o \
> > +     lwip/src/apps/altcp_tls/altcp_tls_mbedtls_mem.o
> > diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > index a8c2fc2ee2cd..ef19821b89e0 100644
> > --- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > +++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > @@ -3,7 +3,7 @@
> >   * Application layered TCP/TLS connection API (to be used from TCPIP thread)
> >   *
> >   * This file provides a TLS layer using mbedTLS
> > - *
> > + *
>
> Unrelated formatting change, do we want to do this in a separate patch maybe?
>
> >   * This version is currently compatible with the 2.x.x branch (current LTS).
> >   */
> >
> > @@ -70,7 +70,6 @@
> >  /* @todo: which includes are really needed? */
> >  #include "mbedtls/entropy.h"
> >  #include "mbedtls/ctr_drbg.h"
> > -#include "mbedtls/certs.h"
> >  #include "mbedtls/x509.h"
> >  #include "mbedtls/ssl.h"
> >  #include "mbedtls/net_sockets.h"
> > @@ -81,8 +80,6 @@
> >  #include "mbedtls/ssl_cache.h"
> >  #include "mbedtls/ssl_ticket.h"
> >
> > -#include "mbedtls/ssl_internal.h" /* to call mbedtls_flush_output after ERR_MEM */
> > -
> >  #include <string.h>
> >
> >  #ifndef ALTCP_MBEDTLS_ENTROPY_PTR
> > @@ -132,6 +129,16 @@ static err_t altcp_mbedtls_lower_recv_process(struct altcp_pcb *conn, altcp_mbed
> >  static err_t altcp_mbedtls_handle_rx_appldata(struct altcp_pcb *conn, altcp_mbedtls_state_t *state);
> >  static int altcp_mbedtls_bio_send(void *ctx, const unsigned char *dataptr, size_t size);
> >
> > +static void
> > +altcp_mbedtls_flush_output(altcp_mbedtls_state_t *state)
> > +{
> > +  if (state->ssl_context.MBEDTLS_PRIVATE(out_left) != 0) {
> > +    int flushed = mbedtls_ssl_send_alert_message(&state->ssl_context, 0, 0);
> > +    if (flushed) {
> > +      LWIP_DEBUGF(ALTCP_MBEDTLS_DEBUG, ("mbedtls_ssl_send_alert_message failed: %d\n", flushed));
> > +    }
> > +  }
> > +}
> >
> >  /* callback functions from inner/lower connection: */
> >
> > @@ -524,14 +531,14 @@ altcp_mbedtls_lower_sent(void *arg, struct altcp_pcb *inner_conn, u16_t len)
> >      LWIP_ASSERT("state", state != NULL);
> >      LWIP_ASSERT("pcb mismatch", conn->inner_conn == inner_conn);
> >      /* calculate TLS overhead part to not send it to application */
> > -    overhead = state->overhead_bytes_adjust + state->ssl_context.out_left;
> > +    overhead = state->overhead_bytes_adjust + state->ssl_context.MBEDTLS_PRIVATE(out_left);
> >      if ((unsigned)overhead > len) {
> >        overhead = len;
> >      }
> >      /* remove ACKed bytes from overhead adjust counter */
> >      state->overhead_bytes_adjust -= len;
> >      /* try to send more if we failed before (may increase overhead adjust counter) */
> > -    mbedtls_ssl_flush_output(&state->ssl_context);
> > +    altcp_mbedtls_flush_output(state);
> >      /* remove calculated overhead from ACKed bytes len */
> >      app_len = len - (u16_t)overhead;
> >      /* update application write counter and inform application */
> > @@ -559,7 +566,7 @@ altcp_mbedtls_lower_poll(void *arg, struct altcp_pcb *inner_conn)
> >      if (conn->state) {
> >        altcp_mbedtls_state_t *state = (altcp_mbedtls_state_t *)conn->state;
> >        /* try to send more if we failed before */
> > -      mbedtls_ssl_flush_output(&state->ssl_context);
> > +      altcp_mbedtls_flush_output(state);
> >        if (altcp_mbedtls_handle_rx_appldata(conn, state) == ERR_ABRT) {
> >          return ERR_ABRT;
> >        }
> > @@ -683,7 +690,7 @@ altcp_tls_set_session(struct altcp_pcb *conn, struct altcp_tls_session *session)
> >    if (session && conn && conn->state) {
> >      altcp_mbedtls_state_t *state = (altcp_mbedtls_state_t *)conn->state;
> >      int ret = -1;
> > -    if (session->data.start)
> > +    if (session->data.MBEDTLS_PRIVATE(start))
> >        ret = mbedtls_ssl_set_session(&state->ssl_context, &session->data);
> >      return ret < 0 ? ERR_VAL : ERR_OK;
> >    }
> > @@ -776,7 +783,7 @@ altcp_tls_create_config(int is_server, u8_t cert_count, u8_t pkey_count, int hav
> >    struct altcp_tls_config *conf;
> >    mbedtls_x509_crt *mem;
> >
> > -  if (TCP_WND < MBEDTLS_SSL_MAX_CONTENT_LEN) {
> > +  if (TCP_WND < MBEDTLS_SSL_IN_CONTENT_LEN || TCP_WND < MBEDTLS_SSL_OUT_CONTENT_LEN) {
> >      LWIP_DEBUGF(ALTCP_MBEDTLS_DEBUG|LWIP_DBG_LEVEL_SERIOUS,
> >        ("altcp_tls: TCP_WND is smaller than the RX decrypion buffer, connection RX might stall!\n"));
> >    }
> > @@ -900,7 +907,7 @@ err_t altcp_tls_config_server_add_privkey_cert(struct altcp_tls_config *config,
> >      return ERR_VAL;
> >    }
> >
> > -  ret = mbedtls_pk_parse_key(pkey, (const unsigned char *) privkey, privkey_len, privkey_pass, privkey_pass_len);
> > +  ret = mbedtls_pk_parse_key(pkey, (const unsigned char *) privkey, privkey_len, privkey_pass, privkey_pass_len, mbedtls_ctr_drbg_random, &altcp_tls_entropy_rng->ctr_drbg);
> >    if (ret != 0) {
> >      LWIP_DEBUGF(ALTCP_MBEDTLS_DEBUG, ("mbedtls_pk_parse_public_key failed: %d\n", ret));
> >      mbedtls_x509_crt_free(srvcert);
> > @@ -1003,7 +1010,7 @@ altcp_tls_create_config_client_2wayauth(const u8_t *ca, size_t ca_len, const u8_
> >    }
> >
> >    mbedtls_pk_init(conf->pkey);
> > -  ret = mbedtls_pk_parse_key(conf->pkey, privkey, privkey_len, privkey_pass, privkey_pass_len);
> > +  ret = mbedtls_pk_parse_key(conf->pkey, privkey, privkey_len, privkey_pass, privkey_pass_len, mbedtls_ctr_drbg_random, &altcp_tls_entropy_rng->ctr_drbg);
> >    if (ret != 0) {
> >      LWIP_DEBUGF(ALTCP_MBEDTLS_DEBUG, ("mbedtls_pk_parse_key failed: %d 0x%x\n", ret, -1*ret));
> >      altcp_tls_free_config(conf);
> > @@ -1189,7 +1196,7 @@ altcp_mbedtls_sndbuf(struct altcp_pcb *conn)
> >            size_t ret;
> >  #if defined(MBEDTLS_SSL_MAX_FRAGMENT_LENGTH)
> >            /* @todo: adjust ssl_added to real value related to negotiated cipher */
> > -          size_t max_frag_len = mbedtls_ssl_get_max_frag_len(&state->ssl_context);
> > +          size_t max_frag_len = mbedtls_ssl_get_max_in_record_payload(&state->ssl_context);
> >            max_len = LWIP_MIN(max_frag_len, max_len);
> >  #endif
> >            /* Adjust sndbuf of inner_conn with what added by SSL */
> > @@ -1232,9 +1239,9 @@ altcp_mbedtls_write(struct altcp_pcb *conn, const void *dataptr, u16_t len, u8_t
> >    /* HACK: if there is something left to send, try to flush it and only
> >       allow sending more if this succeeded (this is a hack because neither
> >       returning 0 nor MBEDTLS_ERR_SSL_WANT_WRITE worked for me) */
> > -  if (state->ssl_context.out_left) {
> > -    mbedtls_ssl_flush_output(&state->ssl_context);
> > -    if (state->ssl_context.out_left) {
> > +  if (state->ssl_context.MBEDTLS_PRIVATE(out_left)) {
> > +    altcp_mbedtls_flush_output(state);
> > +    if (state->ssl_context.MBEDTLS_PRIVATE(out_left)) {
> >        return ERR_MEM;
> >      }
> >    }
> > @@ -1284,6 +1291,8 @@ altcp_mbedtls_bio_send(void *ctx, const unsigned char *dataptr, size_t size)
> >    while (size_left) {
> >      u16_t write_len = (u16_t)LWIP_MIN(size_left, 0xFFFF);
> >      err_t err = altcp_write(conn->inner_conn, (const void *)dataptr, write_len, apiflags);
> > +    /* try to send data... */
> > +    altcp_output(conn->inner_conn);
> >      if (err == ERR_OK) {
> >        written += write_len;
> >        size_left -= write_len;
> > diff --git a/lib/lwip/lwip/src/core/tcp_out.c b/lib/lwip/lwip/src/core/tcp_out.c
> > index 64579ee5cbd8..b5d312137368 100644
> > --- a/lib/lwip/lwip/src/core/tcp_out.c
> > +++ b/lib/lwip/lwip/src/core/tcp_out.c
> > @@ -1255,14 +1255,6 @@ tcp_output(struct tcp_pcb *pcb)
> >    LWIP_ASSERT("don't call tcp_output for listen-pcbs",
> >                pcb->state != LISTEN);
> >
> > -  /* First, check if we are invoked by the TCP input processing
> > -     code. If so, we do not output anything. Instead, we rely on the
> > -     input processing code to call us when input processing is done
> > -     with. */
> > -  if (tcp_input_pcb == pcb) {
> > -    return ERR_OK;
> > -  }
> > -
> >    wnd = LWIP_MIN(pcb->snd_wnd, pcb->cwnd);
> >
> >    seg = pcb->unsent;
> > @@ -2036,7 +2028,7 @@ tcp_rst(const struct tcp_pcb *pcb, u32_t seqno, u32_t ackno,
> >          u16_t local_port, u16_t remote_port)
> >  {
> >    struct pbuf *p;
> > -
> > +
>
> Unrelated formatting change
>
> >    p = tcp_rst_common(pcb, seqno, ackno, local_ip, remote_ip, local_port, remote_port);
> >    if (p != NULL) {
> >      tcp_output_control_segment(pcb, p, local_ip, remote_ip);
> > diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
> > index 9d618625facb..88d6faf327ae 100644
> > --- a/lib/lwip/u-boot/lwipopts.h
> > +++ b/lib/lwip/u-boot/lwipopts.h
> > @@ -154,4 +154,10 @@
> >  #define MEMP_MEM_INIT                        1
> >  #define MEM_LIBC_MALLOC                      1
> >
> > +#if defined(CONFIG_MBEDTLS_LIB_TLS)
> > +#define LWIP_ALTCP                      1
> > +#define LWIP_ALTCP_TLS                  1
> > +#define LWIP_ALTCP_TLS_MBEDTLS          1
> > +#endif
> > +
> >  #endif /* LWIP_UBOOT_LWIPOPTS_H */
>
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
>
> Thanks,

Thanks I'll get rid of the line changes in v3

> --
> Jerome
