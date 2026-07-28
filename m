Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DADC531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0D80607ED;
	Tue, 28 Jul 2026 11:34:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WaQn2wDqA-Xi; Tue, 28 Jul 2026 11:34:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECD5C607D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238448;
	bh=YKAoFNI4uNKq4foBs6K8cFKPbkNRSFm2GXNVLbBOf5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fd9BkDih4HeanU0NSOW+lylGA3zTvpBarqHl8RvWCwV0dxDdYA6lmPyj6QmcAE1N0
	 bINY6CkwET9rKUa22bEFkXMR3BpY6a/ste6yfR9Z9uV8doYZAh8d5Y190UOfsFPVK2
	 sx9CZn0GahlvvwgOP1qSe6IyX7g7ulsAw2wTS11LNSaLLAYeoZgKRgxNcRZvZ2Lf5g
	 +xi0N1MQX1wwHQQpMLr3jJqWgefSpdx69J8JlOKXvdpwcqMq3uLx7vgZ3BGP9dfTb4
	 POEMSQ7a61sTmQk+XFgrC7SHw7pzYf6Cb4iEm7Ymib8fviriVM0X0/BU/9es6rNjmO
	 RRsp7c2ZEnZPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECD5C607D5;
	Tue, 28 Jul 2026 11:34:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 764802E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C574409AC
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hnaW7lSnw_mv for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:34:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 39DFE4099C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39DFE4099C
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39DFE4099C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:34:03 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69fc856b00eso2922572a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238442; cv=none;
 d=google.com; s=arc-20260327;
 b=EdG6Fw7+FYemqLx2fh5Z72T+MqfifT/Bfe6PskMiJDonfXnf97Pr5mnjdbVHWvSHoy
 NlkQd7Pkt3Krr9+QhUAVrcQQQXZE1pItjoYzvkxsGmyHhJs9CxLlHHCkBblzcDs6IsHW
 eMD3qxW1cdMpyS0XJ7jm2t8qI29lyi9vcLn60PLGKkypp7u8C2qyprWnT/EXe8mhuQoC
 esyFP7SQ/lfNeX8Dn9oWh1LNwA0N7DHXlokpPPMe8WGtii6M+++VwEM5upsyaF+GDLRI
 3u1TOfUVNmZkM9+/b/7o/c10weKejHZ4T7ZZtaFKTr0P53KGw8rVAwznm5fE1ssXpPQ6
 vbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YKAoFNI4uNKq4foBs6K8cFKPbkNRSFm2GXNVLbBOf5I=;
 fh=iWjKeRrS1rvg6adXYN0MHQ46IcUBT4v1WAmt/XtMJto=;
 b=KIS1HoRo5SHJGw6PqEjHXWOwECvKhSp/smX6PMzGxt5ZKWANInpzqY1dC3zUvXBXGp
 4oDMaQWtZNc50ZmyyqFmNiAt3N973nkx6g8xMsuFh1WwiiKpdIe0hmSXepQ+oxFZSDeq
 AHjwpxw4s1eOIEOTwGh8f6qh7ZrZRePvKFWj07tatZH5GKxNLzlyFcME5LSoBhFD2S1b
 x87oLqJiCRVh8S3sEHgwcIkDE9PNm8Z2TtjY/Drev4gFqtdRbLVcAZSH7klmPNXPXATS
 EQ5t65ll1tqkoTb/pnOHSu+BBs8JLWxfDGAvuqb2zsQyNPVaMposkwH5V8el2n3iSTxk
 TvlA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238442; x=1785843242;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YKAoFNI4uNKq4foBs6K8cFKPbkNRSFm2GXNVLbBOf5I=;
 b=AXncMVd0cM93QUaWxdAjYNBofba7Qjf6ij6H1QxKLYixOjnekQnAQ85XpffxWkVlJu
 u9ZfTb+hSqA271WBampLqLAsM1GbtTV0IPv7kozP49UscX7dqbqGNjkedJHfgpADQQ78
 u5ax44Ep9yzPdAbuLqi8xJM3IEUK9DYziqVFZuIT00f8KNmqWFMH0N0M5keu4AofbOAT
 xBxcq2BFWXNwEY7NhoeIiEY4lrSV46FXwAaX775bWSQZtcsFC88YXzwYNm4/EjnEMKGe
 t9PlJyco3GRod4BdN7kg3cIGBdsrgKhDsrwH0MBiS4WpnHnk4j0Q6joYuEJ96U7oBlA+
 seeA==
X-Gm-Message-State: AOJu0YyG4O3v+Z9/0JfJIEBJKaEKmir5+U4XRhCT4iKk3Kbz9VyzTw8g
 SMfqNGBkTCTw0rrnmGPxQE5d/Ia6pb1kD7I6VWXhYwq1ce0lMZAM3d0tzHQcve90Q2mHbAKmwR7
 pu+8gUmobSg3ezIWxBBSTI+60VcleepzR76q3GhAD
X-Gm-Gg: AR+sD12DQeIFIQuLUymMmDhvTgm9iiDYkREEQL98wW8AXIMIjWXnq7o2CvTGFjNOyUK
 y6m6PBYK66OvPsJdDZAhxHomMUXttJYJcMtX2eNWOVLSw6eOg2yIkn5SXtU6p4DM1JZBH3WSKQB
 N/i1pG9hcLJgrdW+jfxK4pXwWKeBDIj6uJcNyXCXrBSa7a4AL5OeDmVnNeGrXJVtRusw7QnsFQL
 EgHzAt4GN0jZaSol+xJ4qjHnmzNc+uMKe9fnQhEL8cVZhxJRJV/8EWSa1OT
X-Received: by 2002:a05:6402:371a:b0:69f:b032:a257 with SMTP id
 4fb4d7f45d1cf-6a034a398e7mr1078040a12.22.1785238441957; Tue, 28 Jul 2026
 04:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260721020918.150615-1-marex@nabladev.com>
In-Reply-To: <20260721020918.150615-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:33:48 -0600
X-Gm-Features: AUfX_mwfuHtzfVGtGu71JXdehbm4nRza-7CuJ6CVeoHRPk8j11EsjY9XtHFBEK4
Message-ID: <CAFLszThwmkwpXO6bN2fHzW1Ooo-X9phRS+kuUJm9copMQg=JzA@mail.gmail.com>
Subject: Re: [PATCH v2] binman: nxp_imx8mcst: Handle FCFB header during SPI
 NOR boot
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238442; x=1785843242;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YKAoFNI4uNKq4foBs6K8cFKPbkNRSFm2GXNVLbBOf5I=;
 b=LlXKKeoYGAVIWqpg/lMvyVYSW5i0oNEQID+YeXDDqWX6YZwSvkzdIWVkaBzyOmzN1O
 6TxFf4RtAk89Ii7mOxHt8rnKePi039phsbKrtT5/jDBaZBy0EqJzpOv1j8scl4IR5E9j
 Hokx9umvrZS0jzClV3zPfwXINWLS4oXyZ3upc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LlXKKeoY
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Marek,

On 2026-07-21T02:09:14, Marek Vasut <marex@nabladev.com> wrote:
> binman: nxp_imx8mcst: Handle FCFB header during SPI NOR boot
>
> In case the image that is wrapped in the nxp_imx8mcst already contains
> an FCFB header which is mandatory for SPI NOR boot, then the IVT is at
> offset 0x1000 instead of offset 0x0, but the whole image including the
> FCFB header must be signed to prevent attacker from tampering with any
> of the headers. Add the FCFB handling.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
>
> tools/binman/etype/nxp_imx8mcst.py | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> @@ -101,6 +102,9 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>          # - If it is mkimage'd imx8mimage, then extract to be signed data size
>          #   from imx8mimage header, and calculate CSF blob offset right past
>          #   the SPL from this information.
> +        # - If it is mkimage'd imx8mimage wrapped in FCFB, then extract to be
> +        #   signed data size from imx8mimage header past the FCFB header, and
> +        #   calculate CSF blob offset right past the SPL from this information.

Thanks for updating the block comment.

> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> @@ -114,6 +118,13 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> +        elif signtype == MAGIC_NXP_IMX_FCFB: # SPL/imx8mimage with FCFB
> +            # Sign the payload including FCFB and imx8mimage headers
> +            # (extra 0x1000 and 0x40 bytes before the payload)
> +            signbase -= 0x1040
> +            signsize = struct.unpack('<I', data[4120:4124])[0] - signbase
> +            # Remove mkimage generated padding from the end of data
> +            data = data[:signsize]

This part is not tested:

tools/binman/etype/nxp_imx8mcst.py                         94      3    97%

Also 4120 is still an unexplained decimal literal rather than the FCFB
offset plus the IVT csf-pointer offset. If you don't want to change
that, perhaps add a comment as to where 4120 comes from?

Regards,
Simon
