Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A3EC98338
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 16:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 526DD40642;
	Sun, 27 Sep 2026 16:42:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YfsY3LJbg2e3; Sun, 27 Sep 2026 16:42:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 87CD94063A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527332;
	b=pqisZTU6/cRxHZ4Dn7V96WaZTwt68CtFSd9MNDoE7irtwFGyeMRv5Yj6cpKxopHQIN9D
	 99xhTbDA8aFXdN38SX7pQ+tEBCKGrGhwfGdycNEwDutRLE5iaLd+gayKfrChLuyZ+C4M7
	 iUQFB3ux8xs78eNmni0gkOKa4qSF4JEUcH+vaUgf25TNtKEnPY/SyRvx8Sw+za8FpmVbv
	 DLZzIBaX1CMq4/SohMlbYVWxng6+3X98oK7Ix7qT3+nlzYcOEtXDYSPtZxbbmxuXHE5iM
	 WBbEyJBYr1Z4txQNyGApNNziUepC90mMGOViuYj2Hh1jQkrH9obVUi1BQMDZfck/OWg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790527332;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Of3vGMqSneBA4zXep5IZC2WSPx0RyOC8bWFsvz04jB4=;
	b=rbe4eii4Vl9+PHeeFSy0tO8PIc3+2DKin/uS79cWsewCgX0UKzoqMHulfbflQY9vA7CV
	 hFQ56i975i5Cc8qyswM64HTuQQ+hrxan9tJtP4JoOKoVgYU4l6oeAHheVPs/wth0GamoK
	 WIRisDcUj5kq+5mdM3OkDvqFIAsrdA+TX5mv+Wt0hb8fHspJpEWgOn1yuQ1R/BFUc1PAs
	 VWVfX5tjOafJyMqdHMH4lHUR53d1zyTZg+zfnY39ocBnwwW7U1CdvCSCDtl5+jqfa3P7P
	 vm9GMweOWQ/jSHnClRGisFmQRrByw9qadE992qFyLRrMHQf7bZRPZ37IKOuDXX42hFw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790527332;
	bh=Of3vGMqSneBA4zXep5IZC2WSPx0RyOC8bWFsvz04jB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cq8pDP7jvBJAR0dr1fKmEEtSlKtp+BYOctuu0UaL0D620l+4KOSXF1LKi5sxiJX5i
	 Q2u3xAEc5zOoWOEVCWCmM12gCQB9jlYUdQPlTeZ+lCSzOLq+u1KdwShVp3Oojf8BFB
	 uoqv1bYFbCbGNF5Ybx1ZDND4GQaP4IJxy1ll6k6/63s4+PNAUP1S/+TYdBoQwzwGV4
	 ZJ7AOGd9mv2REvd6xBqURC9eDmlfKj05lK/Gp9+kHXd/NJP0zytAndHBsPnaB3HRwV
	 uYVtfEiOjO14geDrIAM0Q+WY+k0DeRir83hzoTCQYiFp8kVQ1NAlfXPhl40bNGVEUG
	 0/16aZsMexKgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87CD94063A;
	Sun, 27 Sep 2026 16:42:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 10547194
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8E5340068
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qyUWOZ2y54Wg for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 16:42:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B5FDB4002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527329;
 b=MuR6cMPyxr0ijU96ZeP0y1tRdqF8ccdiFkfO5uE1viYoka/uQ0wdx7ElU9k3N8xwTDYl
 y6yb0pvOe/VTFCL4Hs0aycd121iERDze/VIqrU1PGasbxn2hJp6Xq9wJRbP5TaRYgklMD
 el7Ye90C1uaOo8aWA85EhjNpw408Qhcp7C8Q3UGlbEvtVuqg1h93wggW9rFBqcugP12CQ
 amL0JZNGi9iy5cj41LmW5nbipDGbmkNLXkCSCEE2edvxV8ZauZz8ljlPV6bbOX6y/W3L7
 eODtXaw6BgDOP0sgxMz4udDTHSXpHyhtXrgHpHl7g1Fh6x0/taxwdj2amcBoIOn+T/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790527329;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=Of3vGMqSneBA4zXep5IZC2WSPx0RyOC8bWFsvz04jB4=;
 b=E6rnekl11PaNWKgkeoEJLw/dN68fUkm3sGTfIeSzPRYUzRr2BDW5kqpeYYsPrljjeafE
 EwoDoQqZPoBtgZxWWoJ4nVAebxddbBbO2R1WgTZXUQySavlgWmzbP1HXSV4ppNoJmvujT
 TfFbw/qKGFTbRhlM5Bc1liAo3Q2xvA6RKYpynEUmQa4mUeY6i2b+WDqDyX8htve2BtzvW
 IoaOV3a88TVxnALHXj7tgDmVv6NWuHS1q4IWBvUcIkFJ+cELPc/ms7CcqcDYULR+HISMv
 s/UCSK8a0AvTZMIyAE0xUR6DS//ZO6F3+owKOBEUSPz+DApWQVnw8bYvFAaW8qM+SVA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PmNjXddk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PmNjXddk
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5FDB4002B
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:42:07 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac5ef2610aso395009a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 09:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790527326; cv=none;
 d=google.com; s=arc-20260327;
 b=U7WzxZaih65Ry+IMVo1QPI4LttJTuCgPlcsg96uYASldKetibLYVaf5nLIPXtET53k
 zr8/NWpE+HzCBqpXiOuIddYzYKDVgEEn7j8LevCk6HphtBH3OnIasqzVaYUZ+IG9FP8D
 ESGVedWwp8NXiV4FlBKPgxNWeYR8L+E9bIP2qIut9X6GdG/26Xkspn1CdU0x/q8tfdxi
 SZgTxIWlBnNPo9vBn5Pl2F79vHKP1a9U01rHD5iPPH8tO8HsTug2HxLAaVKwRfTU+ezm
 E6Bf7GdJNhvb7Dm0BtNQg98c8LQ8Sv7rHZ8j9BQdiHtGzcnCPi6Nnxx1eVLnPz/qG8iD
 dmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Of3vGMqSneBA4zXep5IZC2WSPx0RyOC8bWFsvz04jB4=;
 fh=qraMckZc7jCpRP8/ViasQITCK3gmkHUxRUeW2N8k9AA=;
 b=iUAFRs3GC4i2QwNj5XMdXCtkbI1j21ZwtI/1Rg4wcD928hsEBhkqKjLTZTJqxjPwKY
 VaXUavkpKC883n5HxpzsTlR1jVe6F2rV9dWObJ6Vhf0Vu+APnyuNkK/HoZgiii57cGVk
 jrEz9hR+y8fAkTDsLcGyIbaLQCC/ga3wJcGAOrMy4brw0mBtG1QmKnw20kIulU76H7pW
 mrPYMYRXeiEEDWxF+cBs8FHMbKMrXGa68r9hJcaM50EwiP04wrcdrqZF+2GgRgVI37GX
 fLbgZQA1IQZSS1ryHC1MmbgHG4MVJWipxZB/Z5NAN+hsnw87LklJXtrmAtMA4Hxr2nN+
 /NsQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790527326; x=1791132126;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Of3vGMqSneBA4zXep5IZC2WSPx0RyOC8bWFsvz04jB4=;
 b=PmNjXddkUsoO3Max0i5X3TbzVchIq2OjfFwRvZ5S5v7E4IUMO4n4BtgysfHHOyzXkn
 cjPkYEYkaeoiBcxSjMopAP1r6RU1fmuTmMb1pEPys/a4cmkYr21rwuDYpP5NMW8RnP6v
 TR9T+2V15T7WvfjZ1TrAaPRtew7xfc2uwneKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790527326; x=1791132126;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Of3vGMqSneBA4zXep5IZC2WSPx0RyOC8bWFsvz04jB4=;
 b=QTd2P95qpCx3T7GDtywN/ZWb5tQjz0idCxLgypYjLGRpVYIzgDBwq0G692FNDpeR2O
 IKEdarh/njCLDuL6d0X5R+H/UMp734aOfMD0MM/+nAnMoaGMbefdOlcDclYiZVkCmPWB
 Ah2jGHDn0qjQpSUMYgeuqbozfAgFwqawJXBrzzSLn2JIq/T4Xa6XQ6VvwHJ1ZYL+YxEN
 asdr0RcfvMSIdu8mZtC3e5yCU1fTbb2UB5jzu2WQMfyQkOlHXc1H7vIUbCLuRBSv7OlI
 pltnROPzFa3f7Xf6dPwBtC7ppUnhB2lFJjDqtMDywUpQGi4JEdDZ4gy+oUqLlTvk8IbF
 dG2w==
X-Gm-Message-State: AFq9FYJuf33krvsK3Wc/NGCIkjm2/gL/ZU9k+NstJrrhjzMVjy5e0WIz
 3ocQrd+TFAePxXfhfyvzIEBthKU9aTiJGumTr3yLtl1vR+uct+VY9HnpdSjpMXrmCCMuaLNkIrJ
 Ve+utji7spJvOz4f73tippLuz89y+ikupQRBTqp6tSw0oiftqu8g=
X-Gm-Gg: AYBFou3oFZNq9s6weficP7qrZCR+DyzuZL8ZUY5x1/5Uvm7s1xDCh0Zx0qtI0LxNRJT
 fGWQomFPP0L+M+KGK0dfvkEhMLfCmeqls1t2fxt0j/AFj5F272JK/XjMmUdkI04Ep9Nn6TYMr03
 YIr+NH819hF9zu06vx+nRVbz88ZgUaqgS8uglNocUMqQD83lgHriRaLgaOQiwHVq4qwlSU99Zz4
 2nz7eMX88M0iyQthGE7zaBHcLWBUuSekFwXyMvpXJ2D5uJ0zM4Rq33wxj1BzGRKNCAQrKL+prMs
 wbNy6S10ddU2Kgyib6krm5RUr7w8QjczsPUt02B+5zd8UZaTt98C5Q==
X-Received: by 2002:a05:6402:1599:b0:6aa:8d3b:a70 with SMTP id
 4fb4d7f45d1cf-6aac90aa3bemr9456052a12.15.1790527325800; Sun, 27 Sep 2026
 09:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790198142.git.joaofl@gmail.com>
 <88953696903a971bc7043628fa2a33a95be794d4.1790198142.git.joaofl@gmail.com>
In-Reply-To: <88953696903a971bc7043628fa2a33a95be794d4.1790198142.git.joaofl@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 10:41:54 -0600
X-Gm-Features: AclHuK_GSTPd9epgXKwhptauH_upqE_B7TqepYmx8Qjek0Kc0Xpxpcjatc5RE90
Message-ID: <CAFLszTjRr37f0jMdHRiYp-kmgAZTPeU10Aw9K-++gHM=vBc2fg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] test: dm: sf: Get the emulator attached to the
 flash slave
To: joaofl@gmail.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 2026-09-23T21:40:27, Jo=C3=A3o Loureiro <joaofl@gmail.com> wrote:
> test: dm: sf: Get the emulator attached to the flash slave
>
> dm_test_spi_flash() picks up its SPI emulator with
> uclass_first_device_err(UCLASS_SPI_EMUL), which assumes the sandbox SPI
> flash emulator is the only device in that uclass. That holds today only
> because the flash emulator is bound lazily, on the first transfer.
>
> As soon as a second SPI emulator is described in the device tree it is
> bound during the devicetree scan and so comes first in the uclass. The
> test then hands a foreign device to sandbox_sf_set_block_protect(),
> which casts its private data to struct sandbox_spi_flash and writes
> past the end of it, corrupting the heap.
>
> Ask for the emulator attached to this particular slave instead, which
> is what the test means, and which stays correct however many SPI
> emulators exist.
>
> Signed-off-by: Jo=C3=A3o Loureiro <joaofl@gmail.com>
>
> test/dm/sf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
