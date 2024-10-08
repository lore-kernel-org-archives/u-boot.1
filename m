Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E136ACF042B
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 23:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A30E88FA7;
	Wed,  9 Oct 2024 01:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HES+CHME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E9188F91; Wed,  9 Oct 2024 01:14:15 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FBD988F91
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 01:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a994277b38bso254813566b.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 16:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728429253; x=1729034053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BYSr2izxryBJ1djwPdZRLFI8qk2wDy5SbqZcNuWoyMg=;
 b=HES+CHME8AXlad0jMCt+4OOMkPMr/wz8d8cNLeuHpwSWxDzTTIJnkWNk+1QS1ggRJ9
 rLV8DHz1vB7XrzD2+U3104+NcZm6zAMik+ZHI8QoQFEJgiomDvCRvw61AaMlxcbEQsI/
 OUHGtgsnxDj+rUKhhybl6FXTPCzJ3f4c9FgVcO+XAQdjQeyiSJ+m76N5qv/V/5bILFo9
 W/f+wiVXVHH4TbR4uQ3L0jYSYq+lFtxO7GED1MP4fmbINjvnfbemOTw6gQhHs4+VKPrm
 zRi5sNaZ4ASwDddQZimotwVhSIAaUp0zsBQuhfyu8ziNpXu7k7sGI9XRpL0+l2rG9QIn
 hrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728429253; x=1729034053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BYSr2izxryBJ1djwPdZRLFI8qk2wDy5SbqZcNuWoyMg=;
 b=CWAsFRnpdLum8+3iDgtmJ+XGR4+i9AaAeymNriycQvRKq23sPGClN8Nq8tu0qtLNAi
 OwIXVGX+B744ZvldGjKhIKRD/OQKdRiEIy1AhTzSQJzqqGlahNpei9Q5Jrl9X/rapF97
 DW6aBC5PmkSL7VTTCywp2NEVvvjA6Sd5Br17GDqu79w7tymR2qygiFUX/fVM4KAt6G5c
 F1951G5h3EaXivzR6W+Md7a+cigko2N3t+Yg3KXM+cBD3ATZ2Yu2wl2Omq6JpqmeoEWp
 6D/Ev5YhaWaeAx3owGZOKMgiK9KprcnPWg9IHyZboG/hmBv3ZL9SPvH91cD02vNWNj76
 QbvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW34FRP3MJua7tjEX2aUxovMWqQIylM7Q+OM5Md+X6VjhggSdMFVdT7vorMQ5LwztIhI/JduQo=@lists.denx.de
X-Gm-Message-State: AOJu0YxwW9mQN56frKmaTafpLmgverUiSAVeVopS3HNOMFWZ645Nmvbs
 i12YFU1Cq6Wq/8N6lFLGxfbm6/CBWUne8H3xr/jI7sJro+r1du37NlQO1/1IXPt29FQ1qb7Dtue
 KwFKQTdcMlFYf02ysjXEVsc1lpkk=
X-Google-Smtp-Source: AGHT+IGeD7hbslicuL6ebhHCH3IGRd5Bpjj0KL9eJxNhjTYT8rjjW6Ih6X9rloaXQbha0UFhFid/k1HxQ9BlOEMh70o=
X-Received: by 2002:a05:6402:241c:b0:5c8:967d:cf47 with SMTP id
 4fb4d7f45d1cf-5c91d5a4fd7mr541373a12.19.1728429252565; Tue, 08 Oct 2024
 16:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241008230205.108375-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241008230205.108375-1-heinrich.schuchardt@canonical.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 9 Oct 2024 00:14:01 +0100
Message-ID: <CALeDE9N4K4z6w1o2R_tkwQpa7f8EisDj_qcO=aqXWhU+rPrnmg@mail.gmail.com>
Subject: Re: [PATCH] net: correct wget_connected debug messages
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

On Wed, 9 Oct 2024 at 00:02, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Remove duplicate debug message in wget_connected()
> * Correct typo 'Connctd'
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  net/wget.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index b4251e0f293..f978adc9f0a 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -248,7 +248,7 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>                         wget_send(action, tcp_seq_num, tcp_ack_num, len);
>                 } else {
>                         debug_cond(DEBUG_WGET,
> -                                  "wget: Connctd pkt %p  hlen %x\n",
> +                                  "wget: Connected Pkt %p hlen %x\n",
>                                    pkt, hlen);
>
>                         pos = strstr((char *)pkt, content_len);
> @@ -273,10 +273,6 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>                                 }
>                         }
>
> -                       debug_cond(DEBUG_WGET,
> -                                  "wget: Connected Pkt %p hlen %x\n",
> -                                  pkt, hlen);
> -
>                         for (i = 0; i < pkt_q_idx; i++) {
>                                 int err;
>
> @@ -288,7 +284,7 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>                                           pkt_q[i].len);
>                                 unmap_sysmem(ptr1);
>                                 debug_cond(DEBUG_WGET,
> -                                          "wget: Connctd pkt Q %p len %x\n",
> +                                          "wget: Conncted pkt Q %p len %x\n",
>                                            pkt_q[i].pkt, pkt_q[i].len);
>                                 if (err) {
>                                         wget_loop_state = NETLOOP_FAIL;
> --
> 2.45.2
>
