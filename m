Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7CACA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 10:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2D638124B;
	Thu,  8 Oct 2026 10:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p0G75eqcl4pn; Thu,  8 Oct 2026 10:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2C14D810C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791454476;
	b=KWTJsoRaHCbeO4ZvHn5uJXMjXrTpP4P7Fvhhw2puy5gIcaHJ74BS4mq7w+YgJNkNf8Xu
	 lTR4afJ8Vgaq1SQXyMJXvZh6tMlvRN788/gV9fSqmriXwMiAWtcwFbOFFKqZ9gvx3FYuH
	 30By9mQnSDIjXVHLNUP1IR1GVnYn3zK6yhcd7HfcSf6Tt5NmwxC3FMHO8DffhM8k/4qGl
	 6TLomqaT88fL2sAhEzUfpQKLMFaA4QN8C70tMhRp6L3VS4Wx9xoyVd/ewKLs/ExQ8wsRA
	 YZGjrzax5soXYkt+L1CKR5pKKOylisbifV/kg9dRB2eoaHL7ev7qAc8p8DF5QfsOkqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791454476;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Igwg6CPzEkK+e3n8drRr7PAWa80sx/5hnOVPxYv5vT4=;
	b=EJHbrogb1du5Zo70twOE331ccIq0ultz6pAduCyr/6pNj83nLHaeuGOyfK+FTsQymrXp
	 L9OFNeSSt/iVpdlFhux+Bc9JNGTfHpm7nvo92VMy8ZK3CrjfXuCEON01gPvbKdF5Q/TGi
	 RXS5b7nX72QCSmVKsjyhppAbFCcN8tTerG+SGFoLzsL8VAb1CiHIXQE6bBCdZZYmu196+
	 Niw++rcCq/Xj4Bruvk1oB80/1fRYtyT6hAntRfUUcQ+ZMGj179vsaS9UPn08O0/d7XxiQ
	 Rp53fpEBW4xZK3dwlG27h/wSSgGQWy3jh0s5Ur7l82eT9Dc2YVr+gf8RGO6khbK0E/A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791454476;
	bh=Igwg6CPzEkK+e3n8drRr7PAWa80sx/5hnOVPxYv5vT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mrKrrxzWws04Oj33G36z3Qk4UXwdvNWz8IqoBkQr0UPlzlJHViNDM1mdeK3fF0mgH
	 gftMJ460Vljsz1kTW8Iy24oRsQaoefWtWrrf+KCwOfLIX+YT8H3HvWSNvrNuKBAmK/
	 XX0517JM/m/AGxIf4uUMLz41mGYSqXRxF/6E3Dt2+zSrauBVNo7VBd+44fDl0LivqN
	 r9RCNqR7O1saybn5kcu6ZCU30DzKx645bD1Vmyhrm0x0v78Iih+gxhq2pxEYCQMkuy
	 70xOsM+m7i3dviG94gjOHKZzYCZ/iHOqBzizbKsIb/Hq2EgHBXZeK7MZLKkWkXcHQE
	 /vqcIOcZdVFWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C14D810C0;
	Thu,  8 Oct 2026 10:14:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F1DB8338
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E354D60811
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G2LUOyESCnuQ for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 10:14:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 70875607FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1135"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791454472;
 b=Me3NN9eewde3DnH4UT9qxMJYqxEZckyHpEourE/3NNqdyHAW1/gEsc8X4fwxfnBM6wfy
 n4Pr0ou8qjcsPOxgiBxQiNtXnP0JnEErKct61YoN4qWuKdYQoEMOgL1D2TTBwra/xTb1P
 uWE2qEw75S4EwdEXzRzHBcYU6raS0AGsRtu8ktkju/WOOrmfCVo8DzwMFlbY/rR2UA70g
 luJsUV1S8G0ChloVv3pPUc5swTEWZYyFRjSq0GM3yTUa1nHdV1fkPD/NUqNpQZSClURqA
 XBqYxXFZ8LnA4kwwhA5xeHeYleWTkg3q0qZdNpVRjKCOb9S3CMhFCfB7tffZeTgTO8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791454472;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Igwg6CPzEkK+e3n8drRr7PAWa80sx/5hnOVPxYv5vT4=;
 b=b8ke/tPEUKmAePoumbuMxSsZ8+Td9kBUMLgS2jWzF2ISWpQAVJTQHj94zmqPRiFOXrt+
 WausKS/9EQqN6YD0eGOXz1+OTbH/il64qg4m0ye9eiORWaUoajL5i3hAwxNmasMcrfwK2
 rWmHmRJip2tTUtOUdQsleVNLiF9BjqqlI03VdoTdnSm+d9ApsBCME36QiwmB+470ffZEC
 IKxRxQgV9VHCnwmDlKf8IaDyk7QlS+K7wWoK56LoRmY8U3hrQyt2a6vNoc9ZzNIanjZDw
 Pf6+9mHVOiGFYnai5ieQk+hfPqGiPm5jG29pUlXz4X/XdzaUZeBPMU456YC/Yd7o/Xg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lfvjGW73; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lfvjGW73
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70875607FA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:14:31 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8abd68b3937so50120217b3.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 03:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791454470; cv=none;
 d=google.com; s=arc-20260327;
 b=pCRR8ZPhn4R4voZjIcYyuOUD/lbvRelkP9aLWSwSvwdCsHjweh4WgdB62heSESki3R
 DrL2g5jkVrewrh0A7TGyO4tP1Rm9b0xQ8AEgALxpxoqpJwfQQfbfQ8JowMFG93jSg7hr
 eR2uNNRa3knmskM5rKfmLLXANfKGUixKnvz0dJheLY19QvVZ6ntyo/V4+awsGDpr3ZuH
 DajiHf5DwTLI7+eDKEG5cx3Q5wVvLRv6DERHkoMcLZV1YgmvjnfIq5prAYI7gmMZmraZ
 7BYNZkKyoXljyVQmRz9XSPiY+Rs+kl00rHQ3pM1rtkgMyl3OIM5zjH6tIy+oCWw2QU2+
 8Nbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Igwg6CPzEkK+e3n8drRr7PAWa80sx/5hnOVPxYv5vT4=;
 fh=zFCM/c/DsDChw9gi3oxRx06XCt/581I3D0ccNAQ9FqA=;
 b=kFi4CVVgj6KCZI8a740ptl8LjDkAkHLA79nLQ2kuAySP3FjI1zwsR9ggp4Gv3sSYIN
 03jy0YLvHkn+jtWJB9nJz9ow1AenlAGZ2tNbtDqwdlUP3gxTsMC8aJBlrQmcfcjiO3Fd
 twQTxhT/pVUWDu8lDMBbCtElLwXCsSlw8LFvh0TkcboIW/Ntmm7la52LSJSJwDZTRSc0
 uHw9j8Cq/Zyn0P+1YfAXzXH4PmXIOFhGL8zi5tMolkZvsyRjZlIH1w/dlaNq+AxB3A6f
 mKzTOcvFt+FTn5OxGZodcq00eE+HDDMLDbS60nr85smplOZTtkZI8magcRXDGluS5Hq4
 1THg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791454470; x=1792059270;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Igwg6CPzEkK+e3n8drRr7PAWa80sx/5hnOVPxYv5vT4=;
 b=lfvjGW73v8JK9AhQVEJoCe+1LWweUWN4L0ORaIKoPNSeKGXN6N0mIb1uEXeeCeCfS2
 m/c+PE8zwSsop7r89KLt8yXXPbJQSUEOXDHp7SxRp+2EsI4bGkc2xrdi0IqzxdAUgL5A
 /KJ7f8eC8zURscLA2PwA4VBHqn+PKw3kzFJV7FU+C2AUQoXHq0Is8U/b7gjPCBwosMSw
 MjPS38V2Q1Krno4/XfeRtPT99VXp0y5skHCJ+gPLlwfyJaTcAZEvENWBW4yho+NW+Ycj
 C6I8aAzViZMrz9ivqoZRMN8D2P2NKgD2xYLTK4aVWNE+xi13dUMER+oGe5B8H1x9EeeO
 Qalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791454470; x=1792059270;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Igwg6CPzEkK+e3n8drRr7PAWa80sx/5hnOVPxYv5vT4=;
 b=rmInE7M8cjjbqKCex9qt8O5Y3Uh5UWoa52xgRG5j/T+amBRX4LPc9NEdx8VaG+hoTO
 SrwzBHSERC0D+cm5ClPd3DuRCgQ2ikB0PDjO7xDsOv5qIwtv7lgj9NYBBk3xK3u0qfsT
 4RxXgEvhmFMf+bxUzIiZ/if29ClmGRz1e0VVAQUn6DSvqdBWG1xb5EvXFiJIy0Z2Dwsn
 ngBDy9O/sYh7dX3PKHCD3iOItZ0MbsV929AWmU8dWdDltUZoW/ebIJ+J1vDXwaYYZabI
 F6mvkGH/an3q8SBZCx8AA8SQY3QdVWb3tZXz11s+GXmqyWH3i0rA31jWpl2X0JvGUh25
 HEYA==
X-Gm-Message-State: AFq9FYK/ClE+QyqIveL2H8yWJI5YjAF9eLeq/7BCIEVmIjTaHYanpOpx
 +9K/XpQOhOZKLMTcZO5hAAX0yTYm7Cr3+S9ZeDCOLq84ycNWMQ9MCG3w0dpoLzsTxI/TQY9GM4H
 oQO/zN++U2ucpNIdLttCShzd4z9qSOxIkK83yDvDA9g==
X-Gm-Gg: AYBFou2cTDclIlctDCfhw8YinlApAwQrOY8UPN8RrGXV1GY+5AZwwFqDTJdmBk11Ugu
 sw3DTd5gcKOmN2jWUobbeRjEEM0/vHye39Nu/ojJ+aKolTEc28ZKBpoWyBj19tMJBXTHyUWx/o3
 /NbofzDF/SmAv4Izv3iivMmLkJPyVWTC1bNmuMxA2DaDBzQlQYxiGCD78LJOUpcde8RXjtnaLEB
 4K4i1t17mO2RTEPvldwXqMukoroj5O7VO+8NFOQclqmTXNvSZAQii3mqomlMFrI6DhQu/7F+oGP
 cHuK+/wr/V6cqGMVDPZhqcGYrLvOK1RycPa08yiHEzVkQ/OMICzt11XbWl1wi5zOOM+yYZknDtJ
 BDwZ1SqbPjtWgl+VbzfTrQyr3G5pWxJSnCZj+dmtSzcbBsDkLtWwItobrZ/ctW07dp57pJQ75AG
 nKwbCWTBQx+I+aBny4ULnwVpPLpTE381vBEI0jOM7E3BkLuSi/2e1Dn/UlqxMhYZ1zES360CJUo
 9KHbxGQwa9PI2L44mrYGiy7sr/bjgbelZPHvzeUoHYKc4oQ0x+5oCqfcFZM8hTsPkt9+MtE10Mr
 Z7NDtDKxTQWNdQ5SGpoCWQsyEk96S/sakUPJItq8Nj3h0YuZixQkd5Kk1N9ObSHsEja9IDxSiT3
 iyzdKnxwitlPbmP6tQEv3rty3EVE3iyDOFjWpFwHl7FLKNWH8VuL0YQ==
X-Received: by 2002:a05:690c:4f06:b0:873:5bb2:6c13 with SMTP id
 00721157ae682-8b05b0b3a49mr27618727b3.61.1791454470146; Thu, 08 Oct 2026
 03:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
 <20261006155217.187050-4-michael.haener@siemens.com>
In-Reply-To: <20261006155217.187050-4-michael.haener@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Oct 2026 13:13:54 +0300
X-Gm-Features: AclHuK_HM05ytViFn7PKyHDs55bUwEVNZXpCxsPpZinZFHojVKXkZ_4gQGSb2VU
Message-ID: <CAC_iWjLO9LwkF6x9Eq3Rej27A20W_BZ-BXmL43OumemfG17SSA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] xilinx: Use CONFIG_TPM_AUTOSTART on Kria
To: Michael Haener <michael.haener@siemens.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, 6 Oct 2026 at 18:52, Michael Haener <michael.haener@siemens.com> wrote:
>
> The Kria boards start the TPM with a 'tpm autostart' call in the board
> environment. Enable CONFIG_TPM_AUTOSTART instead and drop tpm_setup from
> the environment, so the TPM is started even when the preboot script is
> changed or skipped.
>
> The TPM is now started before preboot, so the TPM reset hints for some
> carrier card revisions are printed after the startup. Boards which still
> have the old environment saved run 'tpm autostart' a second time, which
> is harmless.
>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
> ---
Simon there's also configs/chromebook_coral_defconfig that call the
startup. Do we need to change that as well?

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Changes in v3:
> - New patch
>
>  board/xilinx/zynqmp/zynqmp_kria.env  | 4 +---
>  configs/xilinx_zynqmp_kria_defconfig | 1 +
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 89f48c03586..ed6c1d7ad6f 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -66,7 +66,6 @@ bootmenu_delay=5
>  # Enabling PM nodes for uart0 and can0
>  kd240_setup=zynqmp pmufw node 33; zynqmp pmufw node 47
>
> -tpm_setup=tpm autostart;
>  tpm_reset=echo "!!! For TPM reset a full power cycle or pressing the POR_B button is required !!!";
>  tpm_kv260=if test ${card1_rev} = A -o ${card1_rev} = B -o ${card1_rev} = Y -o ${card1_rev} = Z -o ${card1_rev} = 1; then run tpm_reset; fi
>  tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
> @@ -76,5 +75,4 @@ rtc dev 0; \
>  zynqmp mmio_write 0xFFCA0010 0xfff 0; \
>  if test ${card1_name} = SCK-KV-G; then run tpm_kv260; fi;\
>  if test ${card1_name} = SCK-KR-G; then run tpm_reset; fi;\
> -if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi;\
> -run tpm_setup
> +if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 2eb4fe4e8bf..2f9d6ccf98f 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -222,5 +222,6 @@ CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
>  CONFIG_PANIC_HANG=y
>  CONFIG_MBEDTLS_LIB=y
>  CONFIG_TPM=y
> +CONFIG_TPM_AUTOSTART=y
>  CONFIG_SPL_GZIP=y
>  CONFIG_TOOLS_MKFWUMDATA=y
> --
> 2.55.0
>
