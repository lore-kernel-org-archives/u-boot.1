Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52E2CA5FA9
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 21:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D5214052A;
	Mon, 28 Sep 2026 21:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORX5AEwsWuzn; Mon, 28 Sep 2026 21:29:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AEDCF40523
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790630986;
	b=styy6QJHvH1C4ugXlrvpfKfNXoAwPJJa7zKNXKzVOYlJ3z9H3HVIMqpWHR47zWu9eU5Q
	 8lQQNvsGsMQe6EH13JjQRqAwcx/kQAbmz+a1zm9vdRDbc/YpVDZaEqgGAzfht4nmzhOMs
	 sfcGDv0q3mPk4DD1hG4M27p9geRixP/ebPyqGjtUkApqpMz8ZsBCDKddSXuU3FNAjTmUi
	 q7KGMTlGXg7RPTB6uWBGjthy8L0lTXY8ZCJUNIB07mXc2HNP326zSz9Dlznmv/5ErsF86
	 mpw5Vi8YZnnXFSm6znNaGddD6iqkOgKlKFxTqp0MM08jeQIUNrqygspk7C9nXkgsIZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790630986;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gCQwoaqhtlR0JnE2yD00Ha5uxzHwsRhFkQzUkJJIbzQ=;
	b=A2XmcuxBzZDWBvu2mLbR54c95L2AN2ZxQ71hFz9zSKzQxX94sK/Vtz7OrlpKRhWSw8pa
	 PjO2G48wUKgGO6hRWN1rvQwhH7sIXGkUdPUmuvIdXk36pU605qNufHYGs/X7vuwQM8z0i
	 3LFNuPYgNx1XTKgftPgIyoYVLAjOLbmCoWSCU+H+CzGVwo9dEs78lLI1aoyO98KNxvhPt
	 4HumCMiOfPTFjxYvS6Rfx4NTLyFtsoxwhG/fXwu6pgM1dyUZ4xwXvwHBrdGnCZG8wm70E
	 W5gQhsM561qnz5T6V6b/Qw3FLb9Yz6z/0b8EG0SJdTUsvbwCNga12adSRTt02OFS/lQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790630986;
	bh=gCQwoaqhtlR0JnE2yD00Ha5uxzHwsRhFkQzUkJJIbzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iGW8ah/Fno1Z0U9b2I9bSjnETpaQGw/bF6WTtR7oAyja6l4nFtKcZAQUA1qw3LlTl
	 5jv9sXX3y4NzUFYsPCMQ/ZXROMgCMD5Q6BTRBZWj3DqCNo37BEcgBA0XZ8vfhFc8b+
	 Cs0Vd/2E65UihGniP3IpOkuUlqsTRp3v8u5X2iBDEhH/VYgfeUmPCy4/M83YLoj3a/
	 94Whfzhzt9ksSQLAaD2vTG1k2+PlWOB1T2Y+6AVd92C0CSwOkwfxGyx3JUHKt1Q1Qx
	 +1PKst4Vcr8rKgAugScHJcKjHpoidYyQQOtdpeXGMM70chQfS27cL163kS8LBUqGE8
	 Lej8R8nrfVVjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEDCF40523;
	Mon, 28 Sep 2026 21:29:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A1C78335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 934BF80B33
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:29:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B7liQ1PZoq0W for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 21:29:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CCF2680A58
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::23"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790630984;
 b=B+8JmvMki/iYQm0v631K+6QHGR+h/ve9LvldH17w5ZPUeU/zkBqe+tk4Oq8cGCZCWamm
 ND2MCqk397CblkG22tpqzrrZ9ZNQ4cHBfWpGeJTPKJRSzSWdAVQ8197x6hCkJe4o5IZBE
 8Sa/jCoLv3z8JKQNCMhm5w3s5BbKByvgRFBYx3alr4YsSvn4nGLUb+g/o5ZUL6NQu9o9F
 q05EgX/dvHdVB1bP4GvclRvpAG7AxhUw3KvaCMjoWlUegUQXi/ZO09gfxySQ71ClwaI0w
 z5B3DQSqsYcoNS3aWTKtXxlOb2NAHajbNBWBqE/T5xk9F69TY7Pwnm5Jrw5l4KZGraA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790630984;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=gCQwoaqhtlR0JnE2yD00Ha5uxzHwsRhFkQzUkJJIbzQ=;
 b=CvCR96ERG4bKv+j5JcNBg2kS6664P1Pfqfw4JYXeXIrYVZhGmdNk42KaGcnGFQCSi7QI
 UCcYQ/SK18XNzotc27aF97/BYZmK34ZRS32LuXNhek5K+gOCjK9nK8l6cMT3y8Rx467DM
 zKPz9Af2NqPyV6I+FJvx6DvNMUCzBRpUHNGSneVExZyq5eIsd3FH2PtrO+eiTshsp9pBa
 fUIGnYNRxS2b7wcV/UG/iLUGyJ7UgEBMjG9yiXUUevPU8GStFQC3qovbn6d5+KCwZO8Od
 2QIaWM/ka8NAKCO+JqBy20dKq9mHOXC+Zv/JeraNUAedoINRqhY7sBYEcJGOpAwgvJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sgNH8CYC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::23"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::23; helo=mail-oa2-x23.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=sgNH8CYC
Received: from mail-oa2-x23.google.com (mail-oa2-x23.google.com
 [IPv6:2607:f8b0:4864:30::23])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCF2680A58
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:29:41 +0000 (UTC)
Received: by mail-oa2-x23.google.com with SMTP id
 586e51a60fabf-47b8afe046dso1916333fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790630980; x=1791235780;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gCQwoaqhtlR0JnE2yD00Ha5uxzHwsRhFkQzUkJJIbzQ=;
 b=sgNH8CYCtfFrMGPoLX9X0xdNR4B7lnPCWPmPTIH2ji+8Zcifbr+cDUp7JTzbfNJfAV
 HH4MVvnlqVaWzo2T55RhOxKo1VajsQFUmC6ch3rvPMS6LaWsSJ9tXms4Y7n7gQvpFHwX
 wjIDt9FVORaWNfzFHGgQymlXwTO3hiEi09XTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790630980; x=1791235780;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gCQwoaqhtlR0JnE2yD00Ha5uxzHwsRhFkQzUkJJIbzQ=;
 b=HZOiJkrXjrWKz/WzQztOzq0AoDSm28qDqI6TRJkGhsQ9n/+UbW02dBW04GKK79fEZm
 IPJk3SiUITdiKPBP9M/UVE/AGH1md18XQXgLeM+htmnJs4yJHZj5c33mtD3eeFmF0vUn
 vdVuoA8peeYiNrVxVbYguzbZwI8RRZir9nnj0vECFDyQxALg1pkJCDG3lD3wCWkNwGUJ
 W2xraWbzYPfuAYxN9L1YpoLll6Sa/sadVntC4aiyXL7/CaE//tRGQ4dHxt2coT2pfvCy
 ebEQNlIN/RIpd86bb+eoFZzntpufJbmkbJdP9pCsfivkemX2dVNy1yemB6eGcQ/7ONmQ
 i7eA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZYDaNzfveIkls5hKAlqW/BaaeKof901uz8NzVaS+XoBnxX1P0ujHYiTM+Qpflrqq18KzOL1E=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mocqILbDnXD+9ZM6/MdOy/m9mtT6BLoyxpFzzAnQgcJBfhjLNj
 IJ57uukddaiPpI/2WhzKTXxmY8U6BnD1lDG8wZbeBkdFM5G8GQwd/LsEbaXvOdddJFM=
X-Gm-Gg: AYBFou2YcCw/dBMxE3M/IFc4twqwpHG5Gn/Elw7Zg1Eg3Wp0oWo9jRvRVYOn52uS1ah
 9ZG1KaBdO5iT37/a0k1RehAD3rSvVYoIn4Gaj85icSkpy983ADFJzU7POuV94LUp+zNpEbOMVsa
 eInfRcajPo7+V6YDl7LKHWfCEKZdUzSebDHeqVjzvfR6m4DuZf0S9x63sYftWkGFzAANHi/5XcQ
 Ifv8Z6aIsHb7gzKtsuCTp/71ooQ6FI283a6nn30KXn14Vgkw5O4j4JoJh/wjD2Uz+Uk3X4Q30wZ
 AtqZyem/2r0aYH6c/7wRuG7FKSACHc2qCR5n7IbjZ8gEkzGkwVyibgp2EC2BFNkKECQQSYYnVbE
 IaQfovpBuLc9ySPcjvI84N7B6xxbL/ElXj6diopexurvwaKt/KjCq5hiiLkvA3MnNVubPyc6xpW
 dfFcCnOm7Xmy7HDR/s/LJAK4a6K4sJSsQj4+5JTvdw/665oSgVfnlBeSQk7DQ3V/NSgQ+flDiHB
 Bi7G5Z+WRX/Fk64pWqjpwTvam6qQouB15EMWhrb/H6qP+GOhD3BZ30bsCYmd1kOOwMTgo60JCqK
 3TUtlidpdZ/BFKvOBTh4CoPYGY9VCw==
X-Received: by 2002:a05:6820:1ca3:b0:6d8:5491:3753 with SMTP id
 006d021491bc7-6d854913fb0mr4090433eaf.45.1790630980640; 
 Mon, 28 Sep 2026 14:29:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d5932b91fsm2515338a34.27.2026.09.28.14.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:29:40 -0700 (PDT)
Date: Mon, 28 Sep 2026 15:29:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, mkorpershoek@kernel.org, lukma@denx.de,
 marex@denx.de, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, vandhiadevan.karunamoorthy@oss.qualcomm.com,
 dario.binacchi@amarulasolutions.com, sjg@chromium.org,
 pbrobinson@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 7/8] usb: gadget: fastboot: allow configuring the
 endpoint buffer size
Message-ID: <20260928212937.GV858934@bill-the-cat>
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
 <20260928064041.1432227-8-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rB6VhlUbkFrpXksJ"
Content-Disposition: inline
In-Reply-To: <20260928064041.1432227-8-sumit.dhami@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--rB6VhlUbkFrpXksJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:10:40PM +0530, Sumit Singh Dhami wrote:
> The hard-coded 4096-byte EP_BUFFER_SIZE limits the maximum length of a
> fastboot command received over USB. Long "oem run" commands, such as
> a multi-partition "gpt write", can exceed that and get rejected with
> "buffer overflow".
>=20
> Make the buffer size configurable via CONFIG_FASTBOOT_EP_BUFFER_SIZE,
> defaulting to 4096. The value must stay a multiple of the endpoint's
> maxpacket size.
>=20
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>  drivers/fastboot/Kconfig        | 14 ++++++++++++++
>  drivers/usb/gadget/f_fastboot.c |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index a4539844d89..32609fddecb 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -49,6 +49,20 @@ config TCP_FUNCTION_FASTBOOT
> =20
>  if FASTBOOT
> =20
> +config FASTBOOT_EP_BUFFER_SIZE
> +	hex "Fastboot bulk endpoint buffer size"
> +	default 0x1000
> +	help
> +	  Size of the buffer used for fastboot bulk endpoint transfers.
> +	  This bounds both the maximum length of a fastboot command received
> +	  over USB and the chunk size used during the download data phase.
> +	  A larger value is needed to accept long commands, for example
> +	  "oem run" with a large command string.
> +
> +	  Must be an integral multiple of the endpoint maxpacket size (64,
> +	  512 or 1024 bytes), otherwise transfers break on controllers such
> +	  as DWC3.
> +
>  config FASTBOOT_BUF_ADDR
>  	hex "Define FASTBOOT buffer address"
>  	default 0x82000000 if MX6SX || MX6SL || MX6UL || MX6SLL
> diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastb=
oot.c
> index 8df0e3f331d..d65ed1c70a4 100644
> --- a/drivers/usb/gadget/f_fastboot.c
> +++ b/drivers/usb/gadget/f_fastboot.c
> @@ -31,7 +31,7 @@
>  #define RX_ENDPOINT_MAXIMUM_PACKET_SIZE_1_1  (0x0040)
>  #define TX_ENDPOINT_MAXIMUM_PACKET_SIZE      (0x0040)
> =20
> -#define EP_BUFFER_SIZE			4096
> +#define EP_BUFFER_SIZE		CONFIG_FASTBOOT_EP_BUFFER_SIZE
>  /*
>   * EP_BUFFER_SIZE must always be an integral multiple of maxpacket size
>   * (64 or 512 or 1024), else we break on certain controllers like DWC3

Now that EP_BUFFER_SIZE is user-controlled, do we have some logic
further in the code to introduce a build time failure if what this
comment is saying is not true?

--=20
Tom

--rB6VhlUbkFrpXksJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarrcQQAKCRAr4qD1Cr/k
Cvu+AQDI5iGsEOOQXsJlaX2wk6XkQGeiGXasFvwFNyP+lyWAZAEAiPxCfQ5iZCZP
2jx4z/tdB+3rSppVCfhv65NJ2Rd8Agg=
=Jxb6
-----END PGP SIGNATURE-----

--rB6VhlUbkFrpXksJ--
