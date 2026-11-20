Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA61606A325
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oDkomgbh;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxegGhi+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBC7B60E41;
	Fri, 20 Nov 2026 00:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id swsU14EKuZFX; Fri, 20 Nov 2026 00:53:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17F1F60E02
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795135998;
	b=WYROmzFTwrB5qBO7llrGhC6eA/TXTBMaT0mzkTD0VbV0a3ry0zgw2Mqa/98YPQuIVtBa
	 IFFzDvtgrvjQscldZhRMDrkIR+5ONxMQpGYrrdymbjNsBFYjEB1xxsljmHg63WBvRXKNl
	 8O+tgLjZBiGOzTiKDlTs8TkYf03HsYVeuIrvVWt28madrNiCiEDWorFOwuyD2luXG/WkM
	 eUxD9E6gI7bJa2SWKE6g5zVNWTwW+fmeu54q3ZEg27gMzkEsbBwPivOpm2owfdDloKRBQ
	 yo27hnkpXBRKgx7l3jtqjAd1LwojmqTb1Awh41VBGyh4c8+y73NxY9A2UMg5QaS4aTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795135998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xjh7XBAvYu5i0veViPQTQk518oQzko5twOUqXcMSJR4=;
	b=YGlOyEMRzIFBWkvAT6zGxzO1YRm/JhynpQg6EJhIena/XPnDVNzxSI8fjHlgPDeAX53h
	 msYC+rDNf43Akea1zEJDJKmcgvGkxLCU14hYPeMa9TxZzjiGUVGWh8IMLsHFAzlqxGVt/
	 lS7Y3OGSTwtqqtt2u1Huk8eAJkpbBYZZVvO2XhCeXHGO4klIkPIsmfOjiKczOIx7pomOd
	 MyoanKwVkr5tAQqeAZ2Hzl+qs32NDet9xpSO3y+9ZS+3XlHYGrTO6Dc1mbw9yENU0qyvS
	 MvSg1fJCZvDxO2H3GBv/PrHy+dplk/rBPQ3bPGcBjVGORkyl0zQLmykqCQpwoI0ypgw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795135998;
	bh=xjh7XBAvYu5i0veViPQTQk518oQzko5twOUqXcMSJR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oDkomgbhACnQY9XVlACFDAdGCtVC8u7aa4SnueSuVBqsLfjYRNG3zIAILeA3ejvtn
	 qbCn8AgjqUnRVxTwpRC1fi6FHNm3G09bsj6g8pzwOokXe+8z194DM3lnKGEe6oe39s
	 KeE+sK11cTK+9i1PKRa8sEjpE3RFFOV0tuZ7N/VCrZXvuwhqzphN2NhpoP2JVRTwIX
	 GQy9g6BBQW2lHC0V3xcB5ebGWwAAFJJwbyv85WdnrZibvwhobPOkOks74QfEGjCegE
	 ysRvBSEOTEFGy0E1Kw2aWgMV0AJcUq2wx8BZMbbQb/Stlb8EIFee4NC4bFIME24hSW
	 lOVwZLG9a0Yjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17F1F60E02;
	Fri, 20 Nov 2026 00:53:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78FB0169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B0FB40079
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:53:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVMjhaP40IHZ for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 00:53:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7843C40063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qxegGhi+
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7843C40063
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:53:15 +0000 (UTC)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-675617e81f9so515708d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795135995; x=1795740795;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xjh7XBAvYu5i0veViPQTQk518oQzko5twOUqXcMSJR4=;
 b=qxegGhi+GB2rU+HXDFJSQ2GGX1MyhrDqNaK8nbR+2ffQ02WK3MndNWRiZ14+hAY44r
 8TlJVsMTT4TDQG0YJLltsTeJJO6lHgapvPTtsRlIm6F3prt8jkjnLM5dor0fQRQ1D0hq
 CVCXZxdl3+a4P3iAYzjIstVIn8qDY5WybRPGuRoOngK+6hs10eQPWptfrnFBXy4ODBD4
 KsWd49Aj0PJVng7kzkAPKpaafpnL5XnJwUP1xQpTXaCXybA7hncl0v6qm9WSZtKpgD1p
 RQbEgTM6+OeS6QMD+W1W1XcQKcBrbG5aah7SeuChFFO6ROETi4vpycsHBnyRpkSuxMwO
 daHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795135995; x=1795740795;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xjh7XBAvYu5i0veViPQTQk518oQzko5twOUqXcMSJR4=;
 b=X213bh4nqKJJduYm5/33CwOH4qQeAQ3ALVCorz52lBSNU169JuAMjkVHVctU+paYSo
 OG7xvfA9jgF/uYyOXlHzlfyuhTB13BbfjVLoJ39rh4wFgZDsZXG12ApCcc3AQo19gBPI
 AZDNDkL4sRutXJp5e7b1PeX5UwPZEtya7y7tp8BsYZ85Xo416zbM4xbU4Rj3k7P5H5ti
 Fe1UbajGkk/NvgW2nBEsJpTkDN1DOJoynsESnClRXkdbh9/RZcLzwDvtEHG3o7KwNMt8
 7zZ7qcE07sD3vM+xm1K3aigUd1K7C0cRsGi2cTHhnwnxoLELCcQ3k30+NM4cBEclIu/5
 bHKg==
X-Forwarded-Encrypted: i=1;
 AL+hErHKuPQxTsrbRC9hG0+w2lxoaqW9M2RF1IMuBg5aL+DuMeVItDIU0xRmlQx6+FjEM+HTyYENGRY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9YsuioZ/DMNARvMNZ8nRv8VOtoyMvNpai790yYvxsFs+cGSjtE
 lXtmLnO8x1UTK5d+eGUHW87L4Ku51iF+9ODXYPahJ0/GSZq5x4S9gBa2EWHiQYiRDDdDDSEXojJ
 HGxuZzxZfa7kLlUPXWXrIejUE8XXeKlY=
X-Gm-Gg: AZFdTZfr7X8T9yOROiNJb5ngqRRh3z+AA0PbLhLy8J5bsCUfc0PHtnaFQWIxqP/i7Mt
 tn5SrB8wZd8ofUUoKcj1mxa7jiO+Uw4ga2bIRO1RvyEJZvni2Xl/+9KVrs3ywVYZL9pgDvt22VC
 l7lYxVFI1/Dv70ti23Pd/nDeHtHUbCIkzcXBcE/XruC4yGCwsaHOJ+1mE1oV/3Ze5iAsxFzILHd
 bK5AZq1Y+3TvUh4qsn/ghQggeYBoLMjIPKxKsjs0ED/542eaBVrhY12D41W67NRSHDIjELb8NI6
 CNjPtWq8xrDvskxGMIZY6OhEC9FAfPVRFcYHz49UkKlx5neO7IDld1cE2bSKuyW74rH2RbQRFdo
 zgndHDh3fS8cYGm9aOKIkAs+PzmNaN6bzxSwgEI9DI+3wyJ/F8A/rW1zS4Bgx49SeOJZd2Wr2
X-Received: by 2002:a05:690e:1687:b0:67d:c5bc:c2ad with SMTP id
 956f58d0204a3-67df42bb2c3mr664113d50.11.1795135994761; Thu, 19 Nov 2026
 16:53:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
 <20261113-nvme-fixes-v1-1-a181c72f40e7@flipper.net>
In-Reply-To: <20261113-nvme-fixes-v1-1-a181c72f40e7@flipper.net>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 20 Nov 2026 08:53:02 +0800
X-Gm-Features: AclHuK8-BBadgEzslFgVczziGGD5a_QqsN4yBi7LBaAhBgYq4yaFGpZCMMFQS_M
Message-ID: <CAEUhbmXf+ANcJ=ZiP0t=p78Yq2gj7s=xeK4q3AQLDH5nAJi1FQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] nvme: Wait for commands in seconds,
 not tenths of seconds
To: Alexey Charkov <alchark@flipper.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org,
 Zhikang Zhang <zhikang.zhang@nxp.com>, Wenbin Song <wenbin.song@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Prashant Kamble <prashant.kamble223@gmail.com>, 
 Torsten Duwe <duwe@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 8:00=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> ADMIN_TIMEOUT and IO_TIMEOUT match the admin and I/O command timeouts of
> the Linux driver, 60 and 30 seconds, but nvme_submit_sync_cmd() scales
> them by 100000us, so commands time out after 6 and 3 seconds instead.
>
> That is too short for some drives. A Kingston NV-series disk on a Rock 5B
> takes 3.1-3.2s to complete its first read after power-on, so the GPT prob=
e
> of LBA 0 times out, and the disk is never seen as GPT and offers nothing
> to boot from.
>
> Scale the timeouts by USEC_PER_SEC, so they are the seconds their values
> intend.
>
> Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/nvme/nvme.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>
