Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03EACD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2941381E18;
	Mon, 11 May 2026 20:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VYEQJ7m0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE6CB8341A; Mon, 11 May 2026 20:09:03 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6726F803C6
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd124546379so138954166b.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778522940; cv=none;
 d=google.com; s=arc-20240605;
 b=hUm7cAr4PVdQyqmucjQ9xv5U4tmqrlGSK6Lk3JKXDUH6/zMtQ2mvy+05tvsJiKMTuN
 rrbH9qJ+CXU22r4E7+ZA2WxGPxetPgz/T8CrDbmQUXft5uKm1L98kRNxgVYgAPYxFEaU
 9SKsTDS1A8OrN2vLq5UBUcXKYG9CiKh0A9HDEngCtfD0fYjQyZACgpkyQeDv4DoiDTnq
 pJd2fcRUyb5L0d0QRvfrUNwJk8wfCC65Au8w/obN2fF5uvekTvD+j5ByCYo80XMgQU/K
 heGx5Sl+iqZUZuw1d3GsrDYAk/x98YBthJ0iQRpNtXUITKjcq/vV2sd6cB9v/ypeieHE
 9lJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CJsCNRyKYSDnk4CHJfgzYSRMdLZfjCUTPquPLt0r14c=;
 fh=tRsvz3Em/uqZj8upmXWTx8tJ38Q7cjR5IH6Ts18dPvs=;
 b=fLL1LnLXEO4Ae56eZdQa/2hsh4GFAfR+XQkMTRSpm6gY+eVAZWnN0MtSMcKM2ydB7v
 GjgCK7G3b/EtenyTg6n+1RXD9bjTIRfII6/WwbIC8uLr9lY8CfqYGswJUHdiYOkAzVI2
 bduXATMf4t5XHDkT1BMmBp2EIuQSq2UXNZog4+SoA8uX5l15x7FBHzSf4S+Im7tGuXXC
 rRQab1HNGh2xPr7IkfApxSTxTvKRnqqCrv+6baxeb/Qe84I9+AOyXNHziSINtyw8grys
 5aObm1vBRVUXwnAcicmM7Ct+mO/zxV1WgpU7vJb6UvEaxDgdhs2/85x+2bBRf8A1FLCn
 Tiwg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778522940; x=1779127740; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CJsCNRyKYSDnk4CHJfgzYSRMdLZfjCUTPquPLt0r14c=;
 b=VYEQJ7m03F31e3nekykLp50FZXEmZKoAOgsUJJzo0Lf1dUYq1XOI75BI9ovjYJo7+V
 tdQlGS2ceihz9pqKtuLZlAaYbfWRY8Q4qK9owA/g6kCZf4RA6UeJhbhzABfFUXgcEZdI
 8eWbGbDQ2JZzvdTBa7/AhxuFC8jfgns0mVFvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522940; x=1779127740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJsCNRyKYSDnk4CHJfgzYSRMdLZfjCUTPquPLt0r14c=;
 b=g2ynSP2sXfYWbc3hi1nBo4w8IshDJWS3QW+6coVT/EN7dHcnEAfMTM0nKrG/vvDKTa
 oJc07dfBsXdQJ0C+fY8auCjYjn66Dt22qkC3eX3SJYFSh9QyroDU+rA2iCZbngaLhPau
 gNl8ZAqDdkKlHe+0ukctEnT4782LekgT4h7C+wklYehMZknlkl6lrAVSpLEAfHUie001
 SMWkpCHuQ4rZ6XvlWab83Zgec0F/YNjjk4U8B9hFlwx6D89hcQw2gxHj9eN/kIwsJgqY
 +hwQOHb9X5Vsd2cT6+ydWcsGzK+rWDruFMyDbhzrXwMOgy1TI07O098hklTLkktKqDvG
 87GA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KcTk+FC6G4jFOFenspHbyYqTDSd3CqjkBt/cNegzK8ydT8m/ygvUunONxg3BbKN2PO01U6f0=@lists.denx.de
X-Gm-Message-State: AOJu0YwMAGGdBnRkgBfcSfX0tRdk4iw6Sg7jhClVFfrTQXYwhmoj8MYk
 gtv7aZSBl7cbpe2p8Ni1NkbGPO2poJ5dxCwIVFx8SL5+saDOweuMt9CaZp5tsm7t044/UTaTYl4
 XMilBPw30ye7xA7jmmGVa6+ygXHYg2GWMqA3Vre3y
X-Gm-Gg: Acq92OHoxx3GYOiJuOCZ/Az1MJnnvJFDZ8QIHywsktOdYXgS63eHgz9RdT5HvCEV3pF
 3yj47dNycZFh+HO8AHbZgCfIfH/aHwnrYNPTYIx9UuzvVwHh1WayLXHVdhyynGgagQN9t2PTfES
 /YeCPXx27VGzm0vWRNzcwcuLfWTGncBKkM3mM/c0ho6uGb4CodMogz4Hz7O/wCc9YgIA5Rmq/4N
 fCLxpWRxHeItYHfwifbwIu3+V/RDhMw6x1FOELQRBo5kaaO22miwcTj+V62osTnuFOcTSIjjJDN
 IbFbnA==
X-Received: by 2002:a17:906:ef08:b0:bab:d8e9:53a7 with SMTP id
 a640c23a62f3a-bc56cd297b4mr1607661566b.29.1778522939765; Mon, 11 May 2026
 11:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260509-net-lwip-add-stop-function-v1-1-62d854bfa66a@baylibre.com>
In-Reply-To: <20260509-net-lwip-add-stop-function-v1-1-62d854bfa66a@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:08:47 -0600
X-Gm-Features: AVHnY4JEr30QNywY5qn7F_F-NlCUHet7n7zofiLRBpacx0K44eAlBYIgpL9NY4w
Message-ID: <CAFLszTg7tCbBu5pKivVq2q8DW4pZdGBny4+0PytE7QHXOdOHcg@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: introduce net_lwip_eth_stop() function
To: dlechner@baylibre.com
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
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

Hi David,

On 2026-05-09T17:36:26, David Lechner <dlechner@baylibre.com> wrote:
> net: lwip: introduce net_lwip_eth_stop() function
>
> Add a introduce net_lwip_eth_stop() function and use that to stop the
> network interface after each command that uses the network.
>
> This makes the behavior the same as the legacy net code and avoids
> potential issues with the network interface being left in an active
> state after a command finishes.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> cmd/lwip/ping.c     | 10 ++++++++--
>  cmd/lwip/sntp.c     | 10 ++++++++--
>  include/net-lwip.h  |  1 +
>  net/lwip/dhcp.c     | 15 +++++++++++----
>  net/lwip/dns.c      |  6 +++++-
>  net/lwip/net-lwip.c |  6 +++++-
>  net/lwip/nfs.c      |  4 ++++
>  net/lwip/tftp.c     |  4 ++++
>  net/lwip/wget.c     | 34 ++++++++++++++++++++++------------
>  9 files changed, 68 insertions(+), 22 deletions(-)

> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> @@ -302,6 +302,7 @@ int wget_do_request(ulong dst_addr, char *uri)
>       struct udevice *udev;
>       struct netif *netif;
>       struct wget_ctx ctx;
> +     int ret = CMD_RET_USAGE;
>       char *path;
>       bool is_https;

Initialising ret to CMD_RET_USAGE changes error paths:

   netif = net_lwip_new_netif(udev);
   if (!netif)
        goto out_stop;          /* ret is still CMD_RET_USAGE */

   if (!tls_allocator.arg) {
        log_err(...);
        goto out_remove_netif;  /* ret is still CMD_RET_USAGE */
   }

The fall-through after 'Certificate verification failed' also lands on
out_remove_netif with ret unchanged. These paths previously returned
-1; now they return CMD_RET_USAGE (1), so the command framework prints
usage for a network/TLS failure.

wget_do_request() isn't a command handler either, so CMD_RET_USAGE is
doubly out of place. Please initialise ret to -1 and set ret =
CMD_RET_FAILURE explicitly only in the paths that previously returned
that.

It might make sense to split this up function (perhaps in a prior
patch) to try to make the error handling easier?

> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> @@ -181,7 +181,6 @@ int net_lwip_eth_start(void)
>       int ret;
>
>       net_init();
> -     eth_halt();
>       eth_set_current();
>       ret = eth_init();

Removing the eth_halt() changes the contract of net_lwip_eth_start().
The legacy code in net/net.c still does eth_halt() before eth_init()
in the on-demand-init path, so the claim that this matches legacy
behaviour is only half true.

do_dhcp() with argc > 1 calls do_tftpb() while the interface is still
up, so do_tftpb() now calls net_lwip_eth_start() -> eth_init() without
an intervening halt. I wonder what happens if we have 'dhcp <addr>
<file>' on a board where the driver doesn't support a second
eth_init() without a halt? It may be safer to keep the halt in
net_lwip_eth_start() and treat net_lwip_eth_stop() as the symmetric
counterpart.

> Add a introduce net_lwip_eth_stop() function and use that to stop the
> network interface after each command that uses the network.

Commit message: 'Add a introduce' should be just 'Introduce' (or 'Add a').

Regards,
Simon
