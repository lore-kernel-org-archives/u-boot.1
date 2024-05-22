Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C65FC25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 18:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA7A88210;
	Wed, 22 May 2024 20:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="koYRgylU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D9788287; Wed, 22 May 2024 20:08:01 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA2F881C3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 20:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51f1bf83f06so8251755e87.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716401278; x=1717006078; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c/Fkp/9oPaSRAERdEvHvOgADiysJ1y9E01Scw+riXqw=;
 b=koYRgylUShFyV0aMttMIpC+VE3lRrkNyg2AonlnqzgV5+YWDtQXURoIpx9+UePewZW
 QXMJxExjIlv/qT5FSe2suDj0lyrP/tW5N/LiGWsQICmrbH1ciIH+LWsb+A1DxNaTzuro
 8JUqhMIZsWdK0qL1TKSaEHrm6yRz56q/oyjGUc3SpEtteUCG3GZYS08Qe7yjbztHlwfp
 x5v3tK0t8HC8hkcUH3I/2iCKtYXGdsXSwrXx1CYLnkJyPotLeuUu+6swSyXWQiiplD6z
 0WQpeAdOFE0Ooajzxmappyu/TfHtrQLaNFRaNSWF5QvvBpLswtDpTxFO6B1uzHggPDg5
 Q4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716401278; x=1717006078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c/Fkp/9oPaSRAERdEvHvOgADiysJ1y9E01Scw+riXqw=;
 b=ZGvp7vJYFxKpO1XUZ3sOEbkX6wOoQB3AVwFcVi1i/OJbTMNtf6Gtjb4GKXvI6slMsl
 7GrlqfKc9/xpj6kTZv5/4y+Ytok3FnOKHKgg4rTi7w6fzkPjVIVJA0Sy1pg6UQJ5hj9d
 ZEO0XJGqMhmEWrka5nIiemBFn8RyJS6xIkCA6efGB1oYw2ZKQ6SMWfdjFiNJ9hTG5nR8
 k7wi1mWQuwJkeKp0xC8EKZRxR9DZAk5LRiZvQZDWCD4kvoXrtKpESWM2TN3vwrnIrTIt
 hlvJPokvjc74GQMW2VMqATWatCDWG2if68QgDPOvtO8ag+lhA+5cjdPag7vIgmKv4Qy1
 vJiQ==
X-Gm-Message-State: AOJu0Yy9u6Sc6j+SKymfxCJiSR7RtnIayC48yGyVWY5np1efZpIc4PEK
 E3d2JFI0HuP3jqzhPL52DdB4WssvThQhdMqjKRo7b1kRXUb8rr+rS1TfCDAr7VQtxbzKwnbEfun
 oHytE0AcnJ8/dPjZ+/aDzCyQhg4RvAk40pWcqsw==
X-Google-Smtp-Source: AGHT+IEoYbes89wJ3Urc4gQfIL5TFuzY8LyZ6/MKUDjkIHpoGcLuqO62MBkvZq8tvDJ/i5dAUy07NVS6ynrOOpNcVt4=
X-Received: by 2002:ac2:4295:0:b0:51d:6f21:d3a4 with SMTP id
 2adb3069b0e04-526c0e3ef37mr1783106e87.66.1716401278483; Wed, 22 May 2024
 11:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <52b126477a39fe8e0bdea9fd9ec70b0951aab88b.1716393035.git.jerome.forissier@linaro.org>
In-Reply-To: <52b126477a39fe8e0bdea9fd9ec70b0951aab88b.1716393035.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 22 May 2024 21:07:22 +0300
Message-ID: <CAC_iWj+7ieyyh=aUzuAT7Okjg=PHxb=NDyXy43nKSzeFw3zFwg@mail.gmail.com>
Subject: Re: [PATCH 10/15] test: dm: dsa,
 eth: disable tests when CONFIG_NET_LWIP=y
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>
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

Hi Jerome,

On Wed, 22 May 2024 at 19:04, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Some sandbox tests make strong assumptions on how the network stack is
> implemented. For example, the ping tests assume that ARP resolution
> occurs upon sending out the ICMP packet. This is not always the case
> with the lwIP stack which can cache ARP information.
> Therefore, disable these tests when CONFIG_NET_LWIP is enabled.

Is the ARP Caching the only issue?
U-Boot isn't supposed to use the network stack that much, so it might
be a better idea to disable arp-caching in LWIP (assuming it's
doable). We might even get a few size of bytes back

Cheers
/Ilias
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/dm/dsa.c | 2 ++
>  test/dm/eth.c | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/test/dm/dsa.c b/test/dm/dsa.c
> index c857106eaf..147e2a4afe 100644
> --- a/test/dm/dsa.c
> +++ b/test/dm/dsa.c
> @@ -59,6 +59,7 @@ static int dm_test_dsa_probe(struct unit_test_state *uts)
>
>  DM_TEST(dm_test_dsa_probe, UT_TESTF_SCAN_FDT);
>
> +#if !defined(CONFIG_NET_LWIP)
>  /* This test sends ping requests with the local address through each DSA port
>   * via the sandbox DSA master Eth.
>   */
> @@ -80,3 +81,4 @@ static int dm_test_dsa(struct unit_test_state *uts)
>  }
>
>  DM_TEST(dm_test_dsa, UT_TESTF_SCAN_FDT);
> +#endif /* !defined(CONFIG_NET_LWIP) */
> diff --git a/test/dm/eth.c b/test/dm/eth.c
> index bb3dcc6b95..cf97b1c1ab 100644
> --- a/test/dm/eth.c
> +++ b/test/dm/eth.c
> @@ -170,6 +170,7 @@ static int dm_test_ip6_make_lladdr(struct unit_test_state *uts)
>  DM_TEST(dm_test_ip6_make_lladdr, UT_TESTF_SCAN_FDT);
>  #endif
>
> +#if !defined(CONFIG_NET_LWIP)
>  static int dm_test_eth(struct unit_test_state *uts)
>  {
>         net_ping_ip = string_to_ip("1.1.2.2");
> @@ -298,6 +299,7 @@ static int dm_test_eth_act(struct unit_test_state *uts)
>         return 0;
>  }
>  DM_TEST(dm_test_eth_act, UT_TESTF_SCAN_FDT);
> +#endif /* !CONFIG_NET_LWIP */
>
>  /* Ensure that all addresses are loaded properly */
>  static int dm_test_ethaddr(struct unit_test_state *uts)
> @@ -332,6 +334,7 @@ static int dm_test_ethaddr(struct unit_test_state *uts)
>  }
>  DM_TEST(dm_test_ethaddr, UT_TESTF_SCAN_FDT);
>
> +#if !defined(CONFIG_NET_LWIP)
>  /* The asserts include a return on fail; cleanup in the caller */
>  static int _dm_test_eth_rotate1(struct unit_test_state *uts)
>  {
> @@ -616,6 +619,7 @@ static int dm_test_eth_async_ping_reply(struct unit_test_state *uts)
>  }
>
>  DM_TEST(dm_test_eth_async_ping_reply, UT_TESTF_SCAN_FDT);
> +#endif /* !CONFIG_NET_LWIP */
>
>  #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
>
> --
> 2.40.1
>
