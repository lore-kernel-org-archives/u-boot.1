Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F31C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 14:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BAE846FD;
	Mon,  6 Jul 2026 16:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U8cAY1hp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99779848BF; Mon,  6 Jul 2026 16:14:16 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF0F846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 16:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-8ee88fce536so16903886d6.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 07:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783347253; cv=none;
 d=google.com; s=arc-20260327;
 b=M6MVGqeZvZng2pOc3pK79wmXQOZoPxHRIyWPP54ow2J/BfPPwpObhX04jSwoRvpN2a
 1Hs6ByFkTSWLTQvMEgN/M1a5q9w9/lPntxbizeDwFm8Na/0YuZfvjmfwGq5keGee/8gg
 I1dAyxxyLnoQCsKPp/tdv5CmxtRRTJ0Wu0w+AcElyiluLpjLK7Mdv5lOB6edRBOcdkmN
 rEQ+Wmk5Hc2LjYiWXJ2tYCJtczyZ1o47dp9DTYkldHqVUNoP5pWSCJDXdWDC5Kv4jfYH
 f/HsQmSjDgbmyqSOZUspVrvQS4Mh/NeMQCLugPf/qmToaM0hx+zyo5GTBExQLsno8TRm
 N5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WZJW7NtaFQQmTn4CN/diWUQmvqEfn+WhK5uUgylPhQA=;
 fh=+vNif0XVR7mrRqwMPeJT11S8ZzumVtcYADprkMHe6/8=;
 b=VAE6qNMz6OpGmGahOjSjboyc5Zzvva5TLRcWvb3oXbS75/T2RXM9YaWmlI494VVxwI
 XW+TSrhj6PPfFCgJuBY+8hEc2LYaZ4n4rJZZVZDU9J8fgJgGSd9VYkSl0wWCTuP9+j7k
 fUcc5/R+tJwAQPrIQpQgZgcu/avj/mN6i/A9M5pg1+XUqfilhljZtIRKcf+z9/3ex63t
 ZSAGCy4rZFAOrVQeg+I7Z7YvdfGvA9HHmq+J35A244c6sThHiZpY/bH1dejaWH6ljn39
 kvEiT0VFPUGStQkRSni+0CAN0Q6Om94qTIh64/afw4gla/51KOlY4p1NgiNh9l0DMXQi
 48AQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783347253; x=1783952053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WZJW7NtaFQQmTn4CN/diWUQmvqEfn+WhK5uUgylPhQA=;
 b=U8cAY1hpdStGR5iP3JZBdaK9zo3d1J8qsYwZkC3HyJjKSwze447dN+/ijp9x2mbb4d
 0QopMJjpNwdYEHKnOFu3aaxDZDdSe2ZRe5hb2rqAmAXinCN3I8jlMRXPUC0HX141/BGS
 MigG7JISnJp+K8mldO36R81CKmRrlFIQkbVOntRLzxSG2BM5XopHL0OBnVttAruEtQRZ
 OHX88ijesg/C3zYXytsOwt5WrIJO3CbEjYETCtIffkM9rpLC8ErjY0y+hOKL7/My81ln
 MnOz6FBy2s6A7uOdkCT5mhZoD4I27O3HCtVXClueyPWVvAsMeZ6BP4B5W7dhIHKpKT6I
 xBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783347253; x=1783952053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZJW7NtaFQQmTn4CN/diWUQmvqEfn+WhK5uUgylPhQA=;
 b=OtHzFCiBuqRMWePAIxZI0VydiAhyIVCHz4RPm/VNHgwCsAws/8EWwbKPwoDpQYNCZV
 WtzNfBFeKqg+MD7gz2/kMVqRBIWpHqsJ2HGw1a5gZFIXMTCmgeEAAUN02fWKR/hnzVP3
 R69ZW6C7zyGPhm+mtRZ+Gtq+tlXhUCGbfAKBahdr2Zipx43lgOeiM6OxT8QJ8OyTVDQx
 xU0+kv5pBZWuXMpwY+z3jmZVhC8Zo4TD6Pgw9+MCPBnFMarRVTzD+id3MPTMfUhP40si
 SnXKzRb1BWws54lqSSvaBFiEphULZJkdGHJXpz3BRuq0sNiVyixJdoi4jj/WgsuCZ2Ie
 AMuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqc7biB/TntFyTkxDNmwyYxI63GAz7I+JnHVS4tt3UbWeWIrdoYHQKcpet9Cj+gix5BQxJCWpY=@lists.denx.de
X-Gm-Message-State: AOJu0YzOsPDAiopjyLvM5a0ZlDPXC0XJi9C31tdOtSI7gOxH8FJu6MDH
 dpfZXpAKjmHsLi224H6zMrJBT25J4kOrHZ3K+BDWdTYw0E5bykDmizN5FtsKN0ivQgSZdqFBVx9
 ar7YvdvRbCXBj6OzTeHxc1ZykhZCNPsQ=
X-Gm-Gg: AfdE7cmiTLXnzrG8RWnwifF/OzaJl00XQD1xVEPNCh7hUpuqe5BUOCM+uF4+W7cyiyU
 zfDOwNEVH0S90i8ul9WrPUwxZXOChyDsvqsteoZl79oc65ZmS/3bSVBeDfN/ZyIUeRrRw0zBC5P
 5x0W2tX6qF5BMTdcdEUk7ZAVnYdy1Dgt5Jb8ffVxFkflyXsKqMppKDLWmvzRl6whBcsoLzuL2mf
 AtwCde0PYpiGVYN6ORVSRxa1G3NPfacTSHwnfwmFNwKn2eK3DoVUi7oGb7VdvOc+0xHhSLMpWIE
 PfqWq3BdiW3BqEvpigFmAn/EoFMhdHWPaB2bKRXg8MeM9coMbo2IfVLxkQw8dVYwOTpfHkgQ2Q/
 +ehSYXjic7+p3dyvn/bHG8AE0EiZSkEtvjneWzwheDiQfjo3+V7TSrhC/ivEet/t2Ve0=
X-Received: by 2002:a05:6214:27eb:b0:8e9:f5b0:f61c with SMTP id
 6a1803df08f44-8fcb4b01a2emr7436356d6.44.1783347253014; Mon, 06 Jul 2026
 07:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-master-v1-1-25bae88d130a@bootlin.com>
In-Reply-To: <20260706-master-v1-1-25bae88d130a@bootlin.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 6 Jul 2026 15:14:00 +0100
X-Gm-Features: AVVi8CcKB1u4vudiVvPF3j6q2xRHg4VZM93IfLE5vF_qaJKgs4OvUdnFAfGXSUE
Message-ID: <CALeDE9P-5NG_a0T=dXB2KQcPCGJoSVeRXk6yQPXLesws=ypK6A@mail.gmail.com>
Subject: Re: [PATCH] imx93_frdm: Add OP-TEE device tree node
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>
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

On Mon, 6 Jul 2026 at 13:34, Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
>
> Add missing firmware/optee node, so is can be both used and copied into
> Linux device tree by optee_copy_firmware_node(). This is consistent with
> other i.MX93 boards.

Shouldn't this be going to the upstream Linux DT at which point get it
when we resync?

> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi b/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
> index 41111b1a95a2..2ce9f46b2ad8 100644
> --- a/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
> +++ b/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
> @@ -12,6 +12,13 @@
>                 bootph-pre-ram;
>                 bootph-some-ram;
>         };
> +
> +       firmware {
> +               optee {
> +                       compatible = "linaro,optee-tz";
> +                       method = "smc";
> +               };
> +       };
>  };
>
>  &A55_0 {
>
> ---
> base-commit: 780084d7c07f511da4a39b43277c573156ed42e0
> change-id: 20260706-master-c71a02f504f0
>
> Best regards,
> --
> Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>
