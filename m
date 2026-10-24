Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1B606A31E
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xHLijKE8;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=BTXvOiqg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3843660680;
	Sat, 24 Oct 2026 14:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DgXqZWSCfWsQ; Sat, 24 Oct 2026 14:27:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72B9B60644
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792852021;
	b=Cd9C8meBcXollI34o6wmBsxzQ2u0lSBr5pSZ/sFVGWRC6lTri1OXqWSdjHxnqDXwq2Kr
	 UQGfOVOckPoATSQwMx99yLkdpI4bk4j5o3y0UUqwPSe3OqAZMq0qYY915ze8jEU9spnBm
	 /tquNZcnCIoWa6swJj+aK6/Vnbd5g7Bi5SEkrJsaSubuGuS1LCw7xXaSt7wWDlrOW1TJs
	 VmY3+svjYZN9vPATxToeClRvyvGYvCDvBaegdYgYLQedM7miRZhdZzVtRoDgx3F//C4Tk
	 s592DBKzB5vXzUV76ecI62dmYHe3q1zEXtUVJXO4bo2ol1smAAFD0YCAA1bG67upzfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792852021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uYPnhIahR4tL7n8N6Uap//ecCM922H/7QMfET0Yyxwc=;
	b=IHmUxaoDP0qzDkVs4KR6nNGPjQZ/UfJYj0q/T0U5fcsoBMtvE/u0hkg03y1WWjmuWCNg
	 IT1XvTekSkMXsYyBeb3QseqUNbKuDLfyegiMF2GKgAoNhJGAL2eN85AjMSkxIHm7bctCN
	 iWJWApBIveJhweIj8aezrtppTGPNnuw4v/5Pm+R3k+wMin1JxC3v43HwMeO/BBqFbHhv2
	 tJvoPlSkZZgTjl9mrtVmqxjdWq1oO65VDGTDqkm/0WIJteYIgINBDAGdseaQfOx83BCK+
	 p1To8tfXTVgn5ZfrWWRxVtZ35o6cJ0pci5QlldNh3CMvEr0JYX1HVrmuqr1Hw20MX1g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792852021;
	bh=uYPnhIahR4tL7n8N6Uap//ecCM922H/7QMfET0Yyxwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xHLijKE82q4GtCVhzJgVo9RUccG5aDpjBUEylbhQjLz19eM5vdbytFrtKXGlCVcEE
	 hg2LkBX//kpIiYx7DgxUMi8sLNHd1JssJZSerMCBNgKZWcUB/8uTKTF00g79h2J3HD
	 3wol1isgXUG4yZC6XF8mpD7wY9ZZQUWaeX9xn5/A0y7lGchbIVJ8E1rrK/QJD6p2tr
	 OhRRhp4swYUhHpFtGpE3YtQpPDrSA8QPNgSKm2Urpod4vcMkucvw8ed+ER8jSNIGZR
	 9PGQZ5fMQ+bRAn7BepZEGzwaenQjO/aCVuueDExi4I67P2389tSraQ3MyTh1juzg3K
	 QItIyLeyrxcMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72B9B60644;
	Sat, 24 Oct 2026 14:27:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 22E913C4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09166817B2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:27:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I4QY24KWjU7V for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 14:26:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 47021817B1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792852019;
 b=srdx2HPu59hzlyTTnuIdhlADFLFAmDDYKBeRLlupTcB6vPVI701nj2DXecQdtNprHSqi
 5yj8ZaroBqrs+5hN8UrCek9dbDsqjdMXeqAlm/I/xdVZJJDBsCyuUY3Qed3B65DTdlmos
 Z4RiizQY7ZHrDTElm5/x+1N52MEpwEQjQZwX6/tcEXjhEeI5dAYwEm3CjjWVB4WsmGI6o
 DUDmOCz5Y8dg85H/wkMD3dehQdnV+uQ5LaY8SthVYzITJis7AP9lDJo6gwnPSbUimaRfp
 HvmEZ6PGZAzRSxUcE9ImeV7YSQ7lBvwK7FxW9s7/8ArSnxcLMb/Jjkezr8Deox4rFRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792852019;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=uYPnhIahR4tL7n8N6Uap//ecCM922H/7QMfET0Yyxwc=;
 b=m6+DQGydu4H9zE+mkGkt8LgfWzjs7Bz7XgiZHIUHWHmOwi6SvbRUpsndghLL09yV+8e9
 mQrla/Kfy/MZoctS9s41jlur3Lyl0pjveHxrVArac3ljznwrHtfiRDKXyR53uFfejGL2H
 UxwKNMbA6Rcz3omCh/onSDHAkh6Qlih3DL/H7xlsY+NhyOibeVZHnvlYqnDzOGC+xLiRY
 xiQbpqKNdRG1JPaYzDXFMHPwH5eQ6R17tS3cN+ig8+flismrQXpeO9pZWXOEU9EcKm0WR
 JvbDgPbYc1hXwPPJKhux8DC5dae9aiAdX+OwNw9cUU2FkgsraoYEMsisBHrhrbMQl4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BTXvOiqg; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BTXvOiqg
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47021817B1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:26:58 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6faddda49e7so1513300eaf.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792852018; x=1793456818;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uYPnhIahR4tL7n8N6Uap//ecCM922H/7QMfET0Yyxwc=;
 b=BTXvOiqg4mbyEA5dJQbEXzMOxkOXqNezurgFUUisv4ViEztpU9QetHmuidcpsuRTjt
 +0K8i+QvAC+yfD4UL/wo17PWQdZPbitHR3W9Ix9AhIiUysHQFM0ix5bzCBRNeB9Az/di
 yPKtomoQHXcYn53Nxqb0AxhbGbswnYS8wYcPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792852018; x=1793456818;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uYPnhIahR4tL7n8N6Uap//ecCM922H/7QMfET0Yyxwc=;
 b=1/lA5hSv8jbDAgIHfVPE+zVG2YDjBboTVee8idPAJIP3HTq84iApq7TjCpbClOWMlh
 5MyX6PP1sSIRSeGWGgY+bBcWi849w8AGYA3q87OyFHMQRW9YmFPpIOmOJuORJ6EszCaD
 Vmv+A6WfpBzgcg3TKewU+wBY9D6/VM9HKeHVsh/CxsENDAfkkoFYywDppih2AI916eso
 xJUN2zqp9KMmcEENEStWov69GsJ6i4pQaDOyJTIQm6sZT+cs1mMzuOAyg7to3TbSFl7M
 8d9dsnxAy/c8gi8DQxEdZ22/aid4zau/Sf/DkgdpJxLjzrf7l+U3cykWItGPKbfYIQeL
 OLRw==
X-Forwarded-Encrypted: i=1;
 AKwUvByAHlCUw0AhsTfs8p5KGdFhxilixLwmcvlro52/BN1hJtP65yoFo5leFIfCxBl8Y08AGLwCVVU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIITgWdw4yIr+SoWIveP/qEN82KHY3IwGA6QwotNDRBZcDzwwgF
 cfeTqjAfp7JKpoS2Rc34yGRhgkHvsld5VH1qT9FlJk1OIgXW0qn8DY0OYWDOCSNn8N0=
X-Gm-Gg: AYBFou2FhIskh1aXcTW2gcXK29PEPp5vfiNQ3/TBe5QcfroXgijmnKSOcUNIegBQsG8
 sm3igaVPdQwkpcUdiz3WoH/2rwOdIRAAh2GcN8AoITs5Wky0Kw2fNulhWJTjCLpW7DrRLf7Zld+
 VskwUCZCFywRqZKknST+AcBcBo+j90pvIVNY7dhUxPopTaKLMSfaQoWIpYDJBMZCR6ZhXCCinZV
 LKxXAAHNDaiNL1EHwQtw5+nOSQxB9ZqgGUyQKqlLx8IzwOWe3gl9NxZlaMOrWAT3Y/aJ4njnu5Z
 QWWOaOWz+EgSflXFPWiRQHsa6ghfusU8xYqvTW9v/ajuuLq3kx590Ql3EReRl8xpd3rJ8DmbVMl
 FDOBEGtSMAEgJWMWH/ZdYBVWy9PDPn0GjtS2LTkKZsLkyH3qb6gdUxz12RI8z5ktqX9ISJPn5JQ
 lR+7NSk40WX95omeGh5H8yY1Qak7UT7gTiVVpu5iDkwL3RXf4k/sgwVu6kc5YciNyJEBYddGb8N
 7IOTBqhRyuqjhqghhUnga6L6Qili4DV/T+cUo9fDXwo9Jcq6zF1mc6UlL/r6wnxH7S152q4d0ze
 vlScKKKw2KF4akiPVS540rsbBctneRZzLPiq5NHlzXGLsER4hAh0XTb/1xnHyYsRzo9d0PIDh7S
 Wz3LfdWY770yPwWLukL3tDxvnsfsA+ugzr63q2TKdFlQyRaSVE6S4LFeGnobyPq8gclvAqvbMSh
 GZjZ4=
X-Received: by 2002:a05:6820:a649:10b0:702:f890:e113 with SMTP id
 006d021491bc7-70ba0b5eeb1mr657139eaf.9.1792852017707; 
 Sat, 24 Oct 2026 07:26:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8431c2061sm1290119fac.14.2026.10.24.07.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 07:26:56 -0700 (PDT)
Date: Sat, 24 Oct 2026 08:26:53 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, Macpaul Lin <macpaul.lin@mediatek.com>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 0/2] mediatek: mt8189: apply the DRAM description from
 the bloblist
Message-ID: <20261024142653.GK3596691@bill-the-cat>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ti+w46jwIorLL2Vm"
Content-Disposition: inline
In-Reply-To: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Ti+w46jwIorLL2Vm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 05:32:42PM -0500, David Lechner wrote:

> On the Genio 520 and 720 EVKs (MT8189), the DRAM size and some memory
> reserved for the DRAM controller depend on the DRAM fitted to the board.
> The devicetree built into U-Boot can't describe them, but the boot stage
> which initializes the DRAM has this information.
>=20
> That boot stage can describe them with a devicetree overlay in a
> Firmware Handoff transfer list: a memory node with the DRAM size and a
> no-map reserved-memory node for each reserved region. U-Boot already
> applies such overlays, but only when the transfer list also contains
> the devicetree of U-Boot itself.
>=20
> The first patch makes U-Boot apply the overlays to the devicetree it
> found by other means as well, so that the earlier boot stage only has to
> pass the DRAM information. The second patch enables bloblist support for
> MT8189.
>=20
> The first patch only changes behavior when a transfer list contains
> overlays but no devicetree. As far as I can tell, no board does that
> today.
>=20
> Tested with TF-A BL2 passing the overlay on a Genio 720 EVK (8 GiB).
> U-Boot reports the DRAM size from the overlay and its devicetree
> contains the reserved regions. Without a transfer list, U-Boot uses its
> devicetree as before.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (2):
>       fdtdec: apply bloblist DT overlays to the built-in devicetree
>       configs: mt8189: enable bloblist support
>=20
>  configs/mt8189.config              |  1 +
>  doc/develop/devicetree/control.rst |  5 ++++-
>  lib/fdtdec.c                       | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)

This is an interesting idea I need to think more about. But the first
thing that popped to mind was that something like this, along with SPL +
bloblist on QEMU, might solve the problem Ludwig Nussel is also needing
to solve, for signatures?

--=20
Tom

--Ti+w46jwIorLL2Vm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatzALQAKCRAr4qD1Cr/k
ChAUAP4z+b/0zBw1LpyQQbRKdaDP7GhC0CKV28BuKr5uw08b0AD/ZdQu9wwIBp1s
90SibWR19DuhgBhLFCcJJJuNYoHOFQA=
=xGcU
-----END PGP SIGNATURE-----

--Ti+w46jwIorLL2Vm--
