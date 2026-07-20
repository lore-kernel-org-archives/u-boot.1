Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F924C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1916060674;
	Mon, 20 Jul 2026 08:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1eDNJkRlvTn; Mon, 20 Jul 2026 08:33:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C530D60651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784536426;
	bh=vbVC2uxxMmlbv/DItzL5DEzW7SHzfvZg7xylgFhU2pc=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eo2Ha77kOj1MOuYlT2S0cI0tlp8XvzCTHu7aTmoft6JJTx/M6E2q31MHPQAQDiQu6
	 MSR+KYbWpgeKyPi0b7/pzNdfoqkEkwML9Xlu4Nzs5oETVcS6KeGPBxkVHFI3/1z6Fn
	 iP6vPYL274g/vgvWu/r3nYfhFxVBGvoZpAHmc5JURdv3EYM+cfGQyAzzfsCKA3dLdW
	 uFNbj9heoRsYfZxtafRjt5a+o3JR2x3c8Vwjlk7rfyUaWgqCrdQI2L5dLxsUsEgOwS
	 HN31Pz4b2AqaxK4CHc7HV37SVNNSF5cF0mx18DY+eOyqrBXCI7+jow6ioG7DWyfZ3A
	 mFMJwKFZfXp0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C530D60651;
	Mon, 20 Jul 2026 08:33:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A8F06282
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9FD9D40106
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:33:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2WxrmzV25Vk for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 08:33:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f29; helo=mail-qv1-xf29.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B2A7A40025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2A7A40025
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2A7A40025
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:33:43 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-8f18d92172aso84316146d6.2
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 01:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536422; cv=none;
 d=google.com; s=arc-20260327;
 b=fS1mHSL8/UGmnAJ9bp5OECyGCBf+zFTYDWioGtxV50Wc1xHdjELIGAlKykilw3tMXL
 I6bPEg2ICtE7SS+ipyS78nQgI131OZPwMKuSrdv5aD3XQ8YF6TBnLJ6pF0yDrJAP9W8y
 7TDpieBwig3LsfoQc0zNk+0tX6qI65KptAytHNSCbYbwT1rj6N/5yyuylvJarxpiYKf9
 4nZV7mE4g+xwCa/NqWnmDmL+Y9zYDOOwzYLWj/MlRCTMTAbKtPJu30HA2sDx7L1JISjC
 myYMh2xMFNKoTkchPMQo/vTkzXkOkSlWhNiNzZQKYVX3oh3Wojy+5urTQkoqr9ufUtbt
 8kiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vbVC2uxxMmlbv/DItzL5DEzW7SHzfvZg7xylgFhU2pc=;
 fh=FJNocD74GKmrEzZRCbawol6icJDV3ilG/7+czrr1PBo=;
 b=QKprt2kUMnjbSe8zFf+JNNZeWFxTsJEthnDZ2pCuV5lv/00VHBeBZU6ORNFR3+7NNL
 BfesPorMbAWzJl181JDxyCGPs7asqroO1awg1rZ+hB9MHZfzXcWERo09oau9wn6rVAX4
 If3sC1RfDm41w5RuE/2C5rSbZGwPtwyQp0x5eCeUsQw5THikCrgX55YQCevmRc6NTsxn
 jy4ha551N7MAr1bOjjP+fq7DPHjfla+wvFudDuRKsq/yTZa8jSpe5GqIlm0gIejVtbVl
 bw+p34hRv4U0oX9FIYH9hmSeQjjGOdCOvG0nG5mZaZZEd/Lc1Mww/VNufVe8oHHdjxy0
 RPBQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536422; x=1785141222;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vbVC2uxxMmlbv/DItzL5DEzW7SHzfvZg7xylgFhU2pc=;
 b=Jmh0DTNghRFiDQaINlsJW9y998Y/f5NnPosO0XzjswggXXCikfcgGgy2KsBRH9ZLTH
 HT7MHyj+2pnZUHTBgMRbMzFyD7GsY7ECk2cblcr7zSkYz5O5wmjjP01eVwbVod9YzBcV
 Wk03EA80bL+BPnmZ5wrugI4u9AE6UiNHVV2f/YHaHe1lf41n1RGqtFh+WqMbgCB0d3nR
 jk42NVivLWJCmp00xiBiRPzh4FKoy0wnjygmY71dX9gkm2aakFo6T2Mvn4D/3a0YfiRD
 32Sm+QqgLO6Bw3qweKhcCZST3JYH8pqx7cuBm8r0PamLXLhlk95AXKEDq6oTeT3EAmzH
 5S2A==
X-Gm-Message-State: AOJu0YzTFZoxZDy2x68zVV/xvvAZheN/kvYji6DHNdg3M2PUBoxhPilG
 rCYgw/0bhTBnqXZypxqLBXRDEJpNKObQqngllKJetMJxm8jeQ0Ae+N83B+YdJnTEXyZMi2c6ppx
 oXMY3WOEtdP0EMVGfMqd1OVXGYm8csu4=
X-Gm-Gg: AfdE7cmeJb/vIDaycxcjcO2UldZ3T8mLGe0LwCTEDDfRBpdJrABWKWxdbJdrsvihZz3
 S47PYakTwuFumRAxvS2Kbve0UYjOiu28aI6yhTToLn7kCjqd+KLLV5qwNqeXOuqcmjqudaWkKgq
 00cFi8UXVk5ESNHj9E4d6BOFh5A/bezZcLTgzeK9RJzrhzPprYS/VPSUCrmtxb7W6VqPmywmTQW
 kQmtgMSqQQ+PsYz/Ag9kRknXTzgqKfTokRyxMbdvyOG9KfiujYGFirT5h224hxYFtpTgIssWdSK
 4xAqkrN/r3NC8WD7ERQMcUhwAUYXQOdzprEFkX1mdCU5UNO6NXxz0ZRb6lbogAuLLcibVv1Hih4
 C4NeWbojknEuNFIX9gM8OHkL9WbAHor6B3a0Y3AkA5CXZkb757wlbFJax
X-Received: by 2002:a05:6214:4117:b0:8ce:b2e9:a4bd with SMTP id
 6a1803df08f44-9077832e936mr148636346d6.17.1784536422062; Mon, 20 Jul 2026
 01:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
 <20260720-osuosl-ml-switch-v4-1-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-1-20ec1c334dd2@linaro.org>
Date: Mon, 20 Jul 2026 09:33:29 +0100
X-Gm-Features: AUfX_mzCYlrQ5_lYSmK11Q9aozVrUB6q6pbPBNEBhWt2lNPqUAm4r-hjj5rIGGg
Message-ID: <CALeDE9OJ2xxq=2KNSPkvMHSgNOsOZ6KjkZGoUDZ-SjS+i0-qpg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] tools/patman: Migrate mailing-list to
 lists.u-boot-project.org
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Heiko Stuebner <heiko@sntech.de>, David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784536422; x=1785141222;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vbVC2uxxMmlbv/DItzL5DEzW7SHzfvZg7xylgFhU2pc=;
 b=qXo9ldOmo96K6eW0n6srOPNOsJ8PUFEDVBzS/Hpd9aAcPxy224mEgGbHK9DNXGyUQA
 yF1/ftAQnUHizGJQF49DeNAtdPPaLCvVot7x4t/tl47UrnfR03pQi/MXWWJlnYqrz2GK
 dQv8aE/GPlsKPPpQhTO0PGyunN8YRUKegCkGmRyuTajazJeC19dkSnTB0IAynXOWvrUY
 T49ojcmqhtSIMwSq9Hzowo97FkWBg53Dv9IgVldYaGhMK2gXCem3swuZ2k+A4zbMRbBl
 eJ2F3V9DCcAPE/C6fqoQuW3UA1wVH6Ld6eP4bCmZ09adUQ4PPnwhCBmnxLPv8l6DVPPZ
 9SAw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qXo9ldOm
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Peter Robinson via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Peter Robinson <pbrobinson@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>
Message-ID: <20260720083329._0i63nZzTqtQWMpjzM2TBc84xA5LXYAFU00ly9XC5UY@z>

On Mon, 20 Jul 2026 at 09:23, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The U-Boot Mailing-list is moving to the lists.u-boot-project.org
> domain, so update all references of the list.denx.de to the new
> domain in the patman code.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  tools/patman/settings.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/patman/settings.py b/tools/patman/settings.py
> index 17229e0d823..fe65b1d3fb7 100644
> --- a/tools/patman/settings.py
> +++ b/tools/patman/settings.py
> @@ -162,7 +162,7 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
>  def ReadGitAliases(fname):
>      """Read a git alias file. This is in the form used by git:
>
> -    alias uboot  u-boot@lists.denx.de
> +    alias uboot  u-boot@lists.u-boot-project.org
>      alias wd     Wolfgang Denk <wd@denx.de>

Sadly I don't believe that alias is needed any more so should likely
be dropped too.

Peter

>      Args:
>
> --
> 2.34.1
>
