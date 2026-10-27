Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE333606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FaaVrNYr;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RcMlDIFc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D73F40517;
	Tue, 27 Oct 2026 13:43:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bRn2dmBZZ4SM; Tue, 27 Oct 2026 13:43:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4CD84033D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108626;
	b=pXtSp+EOT25B8pCfcqPGKjlIRFaL4Jrwt0pv0XNXT4SxcEzYyw5F7+PYtTE+GNM7wjRR
	 iW0NUZMjbJh/PIB2/8sG4xhEnSKamqIw901Smav307p4Di08GuuVBSvyLGboIAdJzLLku
	 cBYq4YclirZAvZPOmbfQaPJ3PHRwremxnV/USOBejye9axZb6Zq0NEM8Sh9vhZ7N6jWxm
	 HYEyBCY5uBugHUVcB8oMVxNGyOvaBVq2csRn6zhEduqHY40bkQSirY6l5Y4g8XyOJySuW
	 v0aHwOKJAmEyZM2cxa996/tills0xmf/slhLVLXsJZligM6vioK4FGSGvMs57Q7dVfA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793108626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1ZX9zZ9imhd6OiOvuwmuhRknJdXj7mCx13cWG2350BE=;
	b=VXmI8IOXAHLG+EUagLVaxElA+dVrbwgwIdewgfw6z05ZX4o1et0hEb4pq6RCgOslWcTj
	 wGp9c1UpCy6VzAX/oiCS5LVDDSo3B8sqEiCJDyYdFbiGj654XhWxSDckrPiYDA7yVYiB1
	 +Ctuj/laL6XZSZleetbXWQTK79fWS/jxrNIPLWOOIKGRE5AapNRVCVVE5QE6tPh0fHxDp
	 1sJtzokUT/hAFAlAElQBZUiOc0AzO8tEOJN09oUODyuIPF0Sn+ygWTofduCxj9u9+Bcwa
	 jH3Nw4JVJpqstLdSEUFUKDBa0GL4RRX2ENtyfnc+YJUYZeARzrdikYJ//s3Wbx/a3Gw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793108626;
	bh=1ZX9zZ9imhd6OiOvuwmuhRknJdXj7mCx13cWG2350BE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FaaVrNYru011NS19XdxcDVe1YmXWWgtnOYn/h2zbaGrCLnf2PAs7YPxpVcbaeKZL/
	 XUWawC5lCYpq0PrQqXUhJ0EnV5tdmFY5tDSMTcbhYoqfvbuxtuDCl2AG5IBlZ5NdSu
	 JSTChoYO4zHt7TOqZvZh5Iwj9hfCcRRkOtWFLpgLsg8OmFaEbqIr+aUXvL2S37RA1i
	 a8bo0SUHLa06hCrN24az8y5fX68q53Ptg1vNvYD0b6Il+uBAAiApHtdnrk1ZRJ82Ls
	 HzdJ/r/23HHuRjnFJbc3dQ3TcOByXWVHDPPw4sWLIDf5shtMWvwlAhqzJT/uLlKwPw
	 PBqu83q0KGgFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4CD84033D;
	Tue, 27 Oct 2026 13:43:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 92C8A279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84C0080984
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJc8dEwPrlrz for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:43:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 69CAB80859
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108624;
 b=TTioJsqmub+JsNl0Sq45ETQkGn26lY1XnxQ+xe9al5h8QzOD4e3OCu0CfYXLacAbefAa
 div5N88y3UOkKuL8CuGUsSxIfxgSvxxEiNBMor4xxoS3bMMJQ42l1c68eE4OX0Chika+T
 YgT7f7erVQ3W4V+V/AQiNKzPDUEfBGJ4bfzmXOtZUtmCbM87guL1A4iT6Zy6RbaqHrz6j
 QdE8FFiR/EhVwko8BooPeeiUXSXLbPzsPGb8ztt6TmMfUKQi2blor61pA9uA7WRWjOV99
 gLKeZkT3/aEQdapgDd49xUIok0giNV8FAtjR8oVcNGk7qBihv95kVjtyVNSKT/CYLRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793108624;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=1ZX9zZ9imhd6OiOvuwmuhRknJdXj7mCx13cWG2350BE=;
 b=tRW6MM9dMxK2RdleiTkgU8fQXAFK5xnnh/d4mjQ2gJk0n/LJleVeIVRh6189zAWXsE+F
 vJzEmliiex3KSrqda5t7La53xRednxeG7L9e2jV1bD4ZkdC+8dD5OrkYTzCVYYhfJKSfU
 eMhVx/78yzZ7/t5Za/HTqKIBlFKc9VUmh8Z3Gr+u+oe4+XIbfsQ/8tisDaVePPNBkbK2A
 7Sj1ThgRkT3rsc7NsFdwz852iAJ84pJa4VXIHvdY2vn6RUKxwJCMsHMMqWVYqh2kYBB8v
 w/u8vJjY41+PB6cgEMAHlakxoLZnFcPe1FEXcQ/0PPIvXUt4Bi0r5nkcLRq1BGg+/5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RcMlDIFc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RcMlDIFc
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69CAB80859
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:43:43 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b40fc523faso4579550a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793108622; cv=none;
 d=google.com; s=arc-20260327;
 b=HAPuQVchqZ7Y9iHXylLqX5tDZS7/Tw5CxOC9Hyy6DayWMt3uesDdEc/pphLvrk0hrk
 8FyUfbbIc4Pf0v7zduVpc6LX4wu4BkpQas/TrPxSBnZOxXORgDO2WEVExRFWIfcviJPY
 ImpWfNGywS/jEs/Z2SLhDzcccJBJEKn/kI/92156ZSj3S8nt5bu1DcibVoMPUdmuoy4V
 2Oe78L28q/PH5maKxG2mOfeyDVxzeB49jMciIy5jUPLnFIj11tKHc0hG8Y7VaAXnUb6v
 N4nDH1ygZYhtTtnned45EEd8y6kqgQyfsMZKLbNOn8Fy4EHvA/54nWl4FitL9y5nJvLa
 HZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=1ZX9zZ9imhd6OiOvuwmuhRknJdXj7mCx13cWG2350BE=;
 fh=yFO3p7Qs/4ORmF2dIzXYTAgmfLBZ5uD7Kp1z29oIE3I=;
 b=sFXR7TjKD3GI3NZW151/CpJx5LBE2V6YLNnovcDoLcPt+r07HnlPe3T7iqy3e9GzcE
 VFIR62fOELae1wN2IeDw5E1aiRjAu7DvPxbCgQLzjKqLXrUJ14bkCf+lEKhsZSoZODsW
 /OLJrbdUysp0Pxus62Ih6aufmvQGL4n8KIlR4CP1Gy39Dmw2qIWM3X/BjxvDV4bKQyLw
 qXm9e7mdXe9ROad8Dtd9/yHXR7KwNwX0hdg9CbZUbzQ2MUAbKJm5ww/pb+5EnAA9QAa9
 ruy4+N+lr+YKdWUKMJR5OMa4u2QKa/hu1x3C6bS8Ke4Mt9aEjLECNunFSi4S7U/L14wG
 A13w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793108622; x=1793713422;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1ZX9zZ9imhd6OiOvuwmuhRknJdXj7mCx13cWG2350BE=;
 b=RcMlDIFcgSnuhiHC9XQhRyy3InyGSLNGpb5K97whf2UCM88X3W6vqyZjdhC+MxM34e
 OefrDt3R2EwSST6xTJ9ApF4C0q+rgxyrLAxEdPSE/LGfQINqx7eojkcFPylt5U2SlY1D
 6XTYGjiw/aEsf3YI5T4R7JRDz9CtmuHDCJFn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108622; x=1793713422;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1ZX9zZ9imhd6OiOvuwmuhRknJdXj7mCx13cWG2350BE=;
 b=owtv7gOopPRrtOOyCRBDbk54V5eRZkw8DA0RS7RL0HaVhLea+PFEtDoguDmENJbJb9
 m7nq93uK3vqOAveomcXbcDsu8bfIUFxo2YrVeslyYm2xQ9qKWHLdSAtmIVcsFn+O6g4F
 lKKwlf76BnFPLH78x7jQc+BYXMQGHzwOsI1FIzK1hVRtcwe4Kxd4MFwoHLeBqaadwpOB
 Iol03ucSsvzIq0HkFI+fZkIF2gnkZVqarT2l6iZ+gSHXzQFt6ek5wYLGR6oaorOBsDxT
 ThbWSP1SmxFfORiVXsbZMXspsSaiNDrOM1oDsQLDAKiRs6tZO9Or3IlNrEGOcTRmiNvn
 6LoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGqdsIg7a1jFVL3X5vXNMhemAHzV77InTZxJx2uJODan7pgjRfSXF8RmxVF9w3hBcoxldsWtQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKhfEj9jc68zm4zVfwhGJXJVIA02HPNoIxkUqV5dLUn2XvypOBw
 XtRCXXjD/WFcNSAdWbZzI/HezEll/toyxnu2UfzPxWz7hAsfyPC1CzDYyFQXgC3NTtra7sd0oDa
 wn8FoXmZVSOkhchizyTdHAQMHkZzIDD8DsydHk8Ux
X-Gm-Gg: AYBFou0Nq4FjeQ3LJkufuYoUBg3XlSBnOPzEBq/W34gNkYevH2H6Wt5flMnMQus4MR6
 YGyJx4a5z7JNG/9cqEs32zSx/FJOnTmLmk+aEtoW5XGt95Pkc8UHnoc7v42ANgiU4cKG2kJfFbx
 oPeuoomFzfbwJ+Q+RBPlYDP+AEN2PrlpUhAUh7EN0hcJG1K8yqVXdKU5+JLjpTpHatQqoAMqfOS
 nH/wRHXQm9su7kEKAhoBi/yIpuli7u+O71cxC6L/KkYoA3ppMuqSDGZ6A/p8KYasiGYee+H50qA
 /+oGeEyhZUC/uk00iqhrsuIZN3rfCsdnNpIjMQD766L//hpcZxaygun8eZfC52SUfk2rWy0IFEE
 tOFYEVfqeMPs1syI1YqvLpjSGIHLq++TbL2g=
X-Received: by 2002:a05:6402:1ed4:b0:6b4:88e8:6073 with SMTP id
 4fb4d7f45d1cf-6b488e8653emr950296a12.0.1793108621630; Tue, 27 Oct 2026
 06:43:41 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:43:40 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:38:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027-spi-probe-speed-v2-1-2f27ddb6a03b@iav.lv>
References: <20261027-spi-probe-speed-v2-1-2f27ddb6a03b@iav.lv>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 06:43:40 -0700
X-Gm-Features: AclHuK-bYBNSCv1AZu78p9oqTuwH2viKgA_ZqUIXV1bB_qsOACYSsfcljGlVPEA
Message-ID: <CAFLszTjhw-=KzNfNRHwfQ0VZngsLmSMNG-AbEAyLRu2JwJfXtQ@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: sf: Probe a flash at the requested speed
To: iav@iav.lv
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 2026-10-27T05:57:26, Igor Velkov via B4 Relay
<devnull+iav.iav.lv@kernel.org> wrote:
> cmd: sf: Probe a flash at the requested speed
>
> 'sf probe <bus>:<cs> <speed>' ignores the speed for a flash that has a
> device tree node: the probe, and with it the JEDEC ID read, runs at
> spi-max-frequency, and the requested speed reaches the controller only
> after it.
>
> On ROCK Pi 4A the device tree sets spi-max-frequency = <108000000> and
> the flash does not answer at the resulting clock, at any requested
> speed:
>
>   => sf probe 1:0 1000000
>   jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
>
> Before the probe, set the requested speed in the platform data of the
> device, as _spi_get_bus_and_cs() already does for a device it binds
> without a device tree node, and restore the saved value right after it,
> so the platform data ends up unchanged. slave->mode keeps the device
> tree value. A speed above spi-max-frequency is honoured, as it already
> is after the probe. Only sf probe with an explicit speed changes: sf
> [...]
>
>  cmd/sf.c     | 11 +++++++++++
>  test/dm/sf.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)

> diff --git a/cmd/sf.c b/cmd/sf.c
> @@ -146,7 +146,18 @@ static int do_spi_flash_probe(int argc, char *const argv[])
> +		struct dm_spi_slave_plat *plat = NULL;
> +		uint saved_max_hz = 0;
> +
> +		/* Probe at the requested speed: the flash reads its ID there */
> +		if (!ret && speed) {
> +			plat = dev_get_parent_plat(new);
> +			saved_max_hz = plat->max_hz;
> +			plat->max_hz = speed;
> +		}
>  		flash = spi_flash_probe(bus, cs, speed, mode);
> +		if (plat)
> +			plat->max_hz = saved_max_hz;

This works, but the command now reaches into the SPI uclass's
per-child platform data, which spi_slave_of_to_plat() normally owns.
It also relies on spi_child_pre_probe() copying plat->max_hz into
slave->max_hz, so please can you move this into a helper in
spi-uclass.c, or a variant of spi_flash_probe(), so the command
doesn't depend on those internals? Other callers can keep their
current behaviour.

The mode has the same problem: _spi_get_bus_and_cs() sends the
requested mode to the controller, but the next dm_spi_claim_bus()
restores slave->mode, so 'sf probe 1:0 1000000 3' quietly ignores the
3 for a DT flash. It would be worth handling the mode in the same way,
or at least saying in the commit message why it is left alone. What do
you think?

Regards,
Simon
